class ExchangesController < ApplicationController
  def index
    matching_exchanges = Exchange.all

    @list_of_exchanges_received = matching_exchanges.order({ :created_at => :asc }).where({:id_receiver => session[:user_id]}).where({:status => "pending"})

    @list_of_exchanges_sent = matching_exchanges.order({ :created_at => :asc }).where({:id_sender => session[:user_id]}).where({:status => "pending"})

    @list_of_exchanges_past = matching_exchanges.order({ :created_at => :asc }).where({:id_sender => session[:user_id]}).where.not({:status => "pending"}).or(matching_exchanges.order({ :created_at => :asc }).where({:id_receiver => session[:user_id]}).where.not({:status => "pending"}))


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

  def cancel
    the_id = params.fetch("query_exchange_id")
    the_exchange = Exchange.where({ :id => the_id }).at(0)

    the_exchange.status = params.fetch("query_exchange_status")

    if the_exchange.valid?
      the_exchange.save
      redirect_to("/exchanges", { :notice => "Cancelled successfully."} )
    else
      redirect_to("/exchanges", { :alert => the_exchange.errors.full_messages.to_sentence })
    end
  end

  def close
    the_id = params.fetch("query_exchange_id")
    the_exchange = Exchange.where({ :id => the_id }).at(0)

    the_exchange.status = params.fetch("query_exchange_status")

    if the_exchange.valid?
      
      if the_exchange.status = "accepted"
        
        # create collection
        sender_collection = Collection.new
        sender_collection.id_user = the_exchange.id_sender
        sender_collection.id_album = the_exchange.album_id
        sender_collection.card_number = the_exchange.card_number_to_receive
        sender_collection.exchange_request = true

        sender_card_to_give = Collection.where({:id_user => the_exchange.id_sender}).where({:id_album => the_exchange.album_id }).where({ :card_number => the_exchange.card_number_to_send}).first
                
        receiver_collection = Collection.new
        receiver_collection.id_user = the_exchange.id_receiver
        receiver_collection.id_album = the_exchange.album_id
        receiver_collection.card_number = the_exchange.card_number_to_send
        receiver_collection.exchange_request = true

        receiver_card_to_give = Collection.where({:id_user => the_exchange.id_receiver}).where({:id_album => the_exchange.album_id }).where({ :card_number => the_exchange.card_number_to_receive}).first
        
        
        if sender_collection.valid? && receiver_collection.valid?
          the_exchange.save
          sender_collection.save
          receiver_collection.save
          sender_card_to_give.destroy
          receiver_card_to_give.destroy


          redirect_to("/exchanges", { :notice => "Exchanged successfully."} )
        else
          redirect_to("/exchanges", { :alert => sender_collection.errors.full_messages.to_sentence })
        end
      else
        
        #### NEED TO CREATE SUBTRACT
        redirect_to("/exchanges", { :notice => "Declined successfully."} )
      end
    else
      redirect_to("/exchanges/#{the_exchange.id}", { :alert => the_exchange.errors.full_messages.to_sentence })
    end
  end
end
