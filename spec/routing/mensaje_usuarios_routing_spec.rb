require "spec_helper"

describe MensajeUsuariosController do
  describe "routing" do

    it "routes to #index" do
      get("/mensaje_usuarios").should route_to("mensaje_usuarios#index")
    end

    it "routes to #new" do
      get("/mensaje_usuarios/new").should route_to("mensaje_usuarios#new")
    end

    it "routes to #show" do
      get("/mensaje_usuarios/1").should route_to("mensaje_usuarios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mensaje_usuarios/1/edit").should route_to("mensaje_usuarios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mensaje_usuarios").should route_to("mensaje_usuarios#create")
    end

    it "routes to #update" do
      put("/mensaje_usuarios/1").should route_to("mensaje_usuarios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mensaje_usuarios/1").should route_to("mensaje_usuarios#destroy", :id => "1")
    end

  end
end
