class CartController < ApplicationController
  def show
    @render_cart = false
  end

  def detail
    @cart = Cart.find_by(id: params[:id])
    @order_tickets = @cart.order_tickets
    #pass the @cart to the view
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('cart', partial: 'cart/detail', locals: { cart: @cart })
        ]
      end
      format.html { render :show }
    end

  end  

  def create
    @cart = Cart.new(cart_params)
    
    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_detail_path(@cart.id), notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cart = Cart.find_by(id: session[:cart_id])

    if @cart
      @cart.update(cart_params)
    end

    redirect_to cart_detail_path(@cart.id)
  end

  def add
    @ticket = Ticket.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_order_ticket = @cart.order_tickets.find_by(ticket_id: @ticket.id)
    if current_order_ticket && quantity > 0
      current_order_ticket.update(quantity:)
    elsif quantity <= 0
      current_order_ticket.destroy
    else
      @cart.order_tickets.create(ticket: @ticket, quantity:)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                    partial: 'cart/cart',
                                                    locals: { cart: @cart }),
                              turbo_stream.replace(@ticket)] 
      end
    end 
  end

  def add_all
    @cart = Cart.find_by(id: params[:cart_id])
    @ticket = Ticket.find_by(id: params[:ticket_id])
    @current_cart = Cart.find_by(id: session[:cart_id])
    
    if @cart.nil? && @current_cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    elsif @cart.nil?
      @cart = @current_cart
    end

    params[:tickets].each do |_, ticket_params|
      ticket_id = ticket_params[:id].to_i
      quantity = ticket_params[:quantity].to_i
  
      next if quantity <= 0
      current_order_ticket = @cart.order_tickets.find_by(ticket_id: ticket_id)
  
      if current_order_ticket
        current_order_ticket.update(quantity: current_order_ticket.quantity + quantity)
      else
        order_ticket = OrderTicket.find_by(ticket_id: ticket_id)
  
        if order_ticket && order_ticket.cart.nil?
          order_ticket.update(quantity: quantity, cart: @cart)
        else
          @cart.order_tickets.create(ticket_id: ticket_id, quantity: quantity)
        end
      end
    
    end
  
    redirect_to cart_carthome_path
  end

  def remove
    OrderTicket.find_by(id: params[:id]).destroy
    
      respond_to do |format|
        format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                   partial: 'cart/cart',
                                                   locals: { cart: @cart })]
      end
    end
  end

  def print
    @cart = Cart.find_by(id: params[:id])
    @order_tickets = @cart.order_tickets
    @total = @cart.total

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'print', 
               template: 'cart/print', 
               layout: 'pdf.html',
               page_size: 'A4',
               orientation: 'Portrait',
               javascript_delay: 2000
      end
      
    end
  end
  
  private
  def cart_params
    params.require(:cart).permit(:name, :email, :phone)
  end

end