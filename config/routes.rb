Rails.application.routes.draw do

  # Routes for the Album resource:

  # CREATE
  post("/insert_album", { :controller => "albums", :action => "create" })
          
  # READ
  get("/albums", { :controller => "albums", :action => "index" })
  
  get("/albums/:path_id", { :controller => "albums", :action => "show" })
  
  # UPDATE
  
  post("/modify_album/:path_id", { :controller => "albums", :action => "update" })
  
  # DELETE
  get("/delete_album/:path_id", { :controller => "albums", :action => "destroy" })

  #------------------------------

  get("/", { :controller => "albums", :action => "home" })  

end
