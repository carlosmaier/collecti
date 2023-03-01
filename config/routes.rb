Rails.application.routes.draw do

  # Routes for the Exchange resource:

  # CREATE
  post("/insert_exchange", { :controller => "exchanges", :action => "create" })
          
  # READ
  get("/exchanges", { :controller => "exchanges", :action => "index" })
  
  get("/exchanges/:path_id", { :controller => "exchanges", :action => "show" })
  
  # UPDATE
  
  post("/modify_exchange/:path_id", { :controller => "exchanges", :action => "update" })
  
  # DELETE
  post("/delete_exchange", { :controller => "exchanges", :action => "destroy" })

  #------------------------------

  # Home

  get("/", { :controller => "albums", :action => "index" })

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create" })

  # EDIT PROFILE FORM
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })

  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })

  # SIGN OUT
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })

  #------------------------------

  # Routes for the Collection resource:

  # LINK ALBUM TO USER
  get("/link_collection/:path_id", { :controller => "collections", :action => "link" })
  
  # CREATE
  post("/insert_collection", { :controller => "collections", :action => "create" })

  # READ
  get("/collections", { :controller => "collections", :action => "index" })

  get("/collections/:path_id", { :controller => "collections", :action => "show" })

  # UPDATE

  post("/modify_collection/:path_id", { :controller => "collections", :action => "update" })

  # DELETE
  post("/delete_collection", { :controller => "collections", :action => "destroy" })

  #------------------------------

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
  
  # Other Routes
  
  # REVIEW POSSIBLE EXCHANGES
  get("/albums/:album_id/:card_number", { :controller => "albums", :action => "exchange" })
  
  # ACCEPT EXCHANGE
  post("/close_exchange", { :controller => "exchanges", :action => "close" })

  # CANCEL EXCHANGE
  post("/cancel_exchange", { :controller => "exchanges", :action => "cancel" })
end
