require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FormulariosController do

  # This should return the minimal set of attributes required to create a valid
  # Formulario. As you add validations to Formulario, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "codigo" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FormulariosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all formularios as @formularios" do
      formulario = Formulario.create! valid_attributes
      get :index, {}, valid_session
      assigns(:formularios).should eq([formulario])
    end
  end

  describe "GET show" do
    it "assigns the requested formulario as @formulario" do
      formulario = Formulario.create! valid_attributes
      get :show, {:id => formulario.to_param}, valid_session
      assigns(:formulario).should eq(formulario)
    end
  end

  describe "GET new" do
    it "assigns a new formulario as @formulario" do
      get :new, {}, valid_session
      assigns(:formulario).should be_a_new(Formulario)
    end
  end

  describe "GET edit" do
    it "assigns the requested formulario as @formulario" do
      formulario = Formulario.create! valid_attributes
      get :edit, {:id => formulario.to_param}, valid_session
      assigns(:formulario).should eq(formulario)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Formulario" do
        expect {
          post :create, {:formulario => valid_attributes}, valid_session
        }.to change(Formulario, :count).by(1)
      end

      it "assigns a newly created formulario as @formulario" do
        post :create, {:formulario => valid_attributes}, valid_session
        assigns(:formulario).should be_a(Formulario)
        assigns(:formulario).should be_persisted
      end

      it "redirects to the created formulario" do
        post :create, {:formulario => valid_attributes}, valid_session
        response.should redirect_to(Formulario.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved formulario as @formulario" do
        # Trigger the behavior that occurs when invalid params are submitted
        Formulario.any_instance.stub(:save).and_return(false)
        post :create, {:formulario => { "codigo" => "invalid value" }}, valid_session
        assigns(:formulario).should be_a_new(Formulario)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Formulario.any_instance.stub(:save).and_return(false)
        post :create, {:formulario => { "codigo" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested formulario" do
        formulario = Formulario.create! valid_attributes
        # Assuming there are no other formularios in the database, this
        # specifies that the Formulario created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Formulario.any_instance.should_receive(:update_attributes).with({ "codigo" => "MyString" })
        put :update, {:id => formulario.to_param, :formulario => { "codigo" => "MyString" }}, valid_session
      end

      it "assigns the requested formulario as @formulario" do
        formulario = Formulario.create! valid_attributes
        put :update, {:id => formulario.to_param, :formulario => valid_attributes}, valid_session
        assigns(:formulario).should eq(formulario)
      end

      it "redirects to the formulario" do
        formulario = Formulario.create! valid_attributes
        put :update, {:id => formulario.to_param, :formulario => valid_attributes}, valid_session
        response.should redirect_to(formulario)
      end
    end

    describe "with invalid params" do
      it "assigns the formulario as @formulario" do
        formulario = Formulario.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Formulario.any_instance.stub(:save).and_return(false)
        put :update, {:id => formulario.to_param, :formulario => { "codigo" => "invalid value" }}, valid_session
        assigns(:formulario).should eq(formulario)
      end

      it "re-renders the 'edit' template" do
        formulario = Formulario.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Formulario.any_instance.stub(:save).and_return(false)
        put :update, {:id => formulario.to_param, :formulario => { "codigo" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested formulario" do
      formulario = Formulario.create! valid_attributes
      expect {
        delete :destroy, {:id => formulario.to_param}, valid_session
      }.to change(Formulario, :count).by(-1)
    end

    it "redirects to the formularios list" do
      formulario = Formulario.create! valid_attributes
      delete :destroy, {:id => formulario.to_param}, valid_session
      response.should redirect_to(formularios_url)
    end
  end

end