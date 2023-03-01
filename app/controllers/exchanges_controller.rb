class ExchangesController < ApplicationController
  def index
    matching_exchanges = Exchange.all

    @list_of_exchanges = matching_exchanges.order({ :created_at => :desc })

    render({ :template => "exchanges/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_exchanges = Exchange.where({ :id => the_id })

    @the_exchange = matching_exchanges.at(0)

    render({ :template => "exchanges/show.html.erb" })
  end

  def create
    the_exchange = Exchange.new
    the_exchange.status = "pending"
    the_exchange.album_id = params.fetch("query_album_id")
    the_exchange.id_sender = params.fetch("query_id_sender")
    the_exchange.card_number_to_send = params.fetch("query_card_number_to_send")
    the_exchange.id_receiver = params.fetch("query_id_receiver")
    the_exchange.card_number_to_receive = params.fetch("query_card_number_to_receive")

    if the_exchange.valid?
      the_exchange.save
      redirect_to("/exchanges", { :notice => "Exchange created successfully." })
    else
      redirect_to("/exchanges", { :alert => the_exchange.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_exchange = Exchange.where({ :id => the_id }).at(0)

    the_exchange.status = params.fetch("query_status")
    the_exchange.album_id = params.fetch("query_album_id")
    the_exchange.id_sender = params.fetch("query_id_sender")
    the_exchange.card_number_to_send = params.fetch("query_card_number_to_send")
    the_exchange.id_receiver = params.fetch("query_id_receiver")
    the_exchange.card_number_to_receive = params.fetch("query_card_number_to_receive")

    if the_exchange.valid?
      the_exchange.save
      redirect_to("/exchanges/#{the_exchange.id}", { :notice => "Exchange updated successfully."} )
    else
      redirect_to("/exchanges/#{the_exchange.id}", { :alert => the_exchange.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_exchange = Exchange.where({ :id => the_id }).at(0)

    the_exchange.destroy

    redirect_to("/exchanges", { :notice => "Exchange deleted successfully."} )
  end

end
