class ShopsController < ApplicationController
  def index
    @events = Event.all
    @tickets = Ticket.all
  end

  def show
    @event = Event.find(params[:id])
    @ticket = Ticket.find(params[:id])
  end
end
