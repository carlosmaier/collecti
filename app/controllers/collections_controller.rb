class CollectionsController < ApplicationController
  def index
    matching_collections = Collection.all

    @list_of_collections = matching_collections.order({ :created_at => :desc })

    render({ :template => "collections/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_collections = Collection.where({ :id => the_id })

    @the_collection = matching_collections.at(0)

    render({ :template => "collections/show.html.erb" })
  end

  def link
    the_collection = Collection.new
    the_collection.id_user = session.fetch(:user_id)
    the_collection.id_album = params.fetch("path_id")
    the_collection.card_number = 0

    if the_collection.valid?
      the_collection.save
      redirect_to("/albums/#{the_collection.id_album}", { :notice => "Collection created successfully." })
    else
      redirect_to("/albums", { :alert => the_collection.errors.full_messages.to_sentence })
    end
  end


  def create
    the_collection = Collection.new
    the_collection.id_user = params.fetch("query_id_user")
    the_collection.id_album = params.fetch("query_id_album")
    the_collection.card_number = params.fetch("query_card_number")

    if the_collection.valid?
      the_collection.save
      redirect_to("/albums/#{the_collection.id_album}", { :notice => "Collection created successfully." })
    else
      redirect_to("/collections", { :alert => the_collection.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_collection = Collection.where({ :id => the_id }).at(0)

    the_collection.id_user = params.fetch("query_id_user")
    the_collection.id_album = params.fetch("query_id_album")
    the_collection.card_number = params.fetch("query_card_number")

    if the_collection.valid?
      the_collection.save
      redirect_to("/collections/#{the_collection.id}", { :notice => "Collection updated successfully."} )
    else
      redirect_to("/collections/#{the_collection.id}", { :alert => the_collection.errors.full_messages.to_sentence })
    end
  end

  def destroy

    id_user = params.fetch("query_id_user")
    id_album = params.fetch("query_id_album")
    card_number = params.fetch("query_card_number")

    the_collection = Collection.where({:id_user => id_user}).where({:id_album => id_album }).where({ :card_number => card_number}).first

    if the_collection != nil
      the_collection.destroy
      redirect_to("/albums/#{id_album}", { :notice => "Collection deleted successfully."} )
    else
      redirect_to("/albums/#{id_album}", { :alert => "Card not found in collection" })
    end

  end
end
