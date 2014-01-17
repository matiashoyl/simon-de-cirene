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

describe MensajeUsuariosController do

  # This should return the minimal set of attributes required to create a valid
  # MensajeUsuario. As you add validations to MensajeUsuario, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "mensaje_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MensajeUsuariosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all mensaje_usuarios as @mensaje_usuarios" do
      mensaje_usuario = MensajeUsuario.create! valid_attributes
      get :index, {}, valid_session
      assigns(:mensaje_usuarios).should eq([mensaje_usuario])
    end
  end

  describe "GET show" do
    it "assigns the requested mensaje_usuario as @mensaje_usuario" do
      mensaje_usuario = MensajeUsuario.create! valid_attributes
      get :show, {:id => mensaje_usuario.to_param}, valid_session
      assigns(:mensaje_usuario).should eq(mensaje_usuario)
    end
  end

  describe "GET new" do
    it "assigns a new mensaje_usuario as @mensaje_usuario" do
      get :new, {}, valid_session
      assigns(:mensaje_usuario).should be_a_new(MensajeUsuario)
    end
  end

  describe "GET edit" do
    it "assigns the requested mensaje_usuario as @mensaje_usuario" do
      mensaje_usuario = MensajeUsuario.create! valid_attributes
      get :edit, {:id => mensaje_usuario.to_param}, valid_session
      assigns(:mensaje_usuario).should eq(mensaje_usuario)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new MensajeUsuario" do
        expect {
          post :create, {:mensaje_usuario => valid_attributes}, valid_session
        }.to change(MensajeUsuario, :count).by(1)
      end

      it "assigns a newly created mensaje_usuario as @mensaje_usuario" do
        post :create, {:mensaje_usuario => valid_attributes}, valid_session
        assigns(:mensaje_usuario).should be_a(MensajeUsuario)
        assigns(:mensaje_usuario).should be_persisted
      end

      it "redirects to the created mensaje_usuario" do
        post :create, {:mensaje_usuario => valid_attributes}, valid_session
        response.should redirect_to(MensajeUsuario.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved mensaje_usuario as @mensaje_usuario" do
        # Trigger the behavior that occurs when invalid params are submitted
        MensajeUsuario.any_instance.stub(:save).and_return(false)
        post :create, {:mensaje_usuario => { "mensaje_id" => "invalid value" }}, valid_session
        assigns(:mensaje_usuario).should be_a_new(MensajeUsuario)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MensajeUsuario.any_instance.stub(:save).and_return(false)
        post :create, {:mensaje_usuario => { "mensaje_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested mensaje_usuario" do
        mensaje_usuario = MensajeUsuario.create! valid_attributes
        # Assuming there are no other mensaje_usuarios in the database, this
        # specifies that the MensajeUsuario created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        MensajeUsuario.any_instance.should_receive(:update_attributes).with({ "mensaje_id" => "1" })
        put :update, {:id => mensaje_usuario.to_param, :mensaje_usuario => { "mensaje_id" => "1" }}, valid_session
      end

      it "assigns the requested mensaje_usuario as @mensaje_usuario" do
        mensaje_usuario = MensajeUsuario.create! valid_attributes
        put :update, {:id => mensaje_usuario.to_param, :mensaje_usuario => valid_attributes}, valid_session
        assigns(:mensaje_usuario).should eq(mensaje_usuario)
      end

      it "redirects to the mensaje_usuario" do
        mensaje_usuario = MensajeUsuario.create! valid_attributes
        put :update, {:id => mensaje_usuario.to_param, :mensaje_usuario => valid_attributes}, valid_session
        response.should redirect_to(mensaje_usuario)
      end
    end

    describe "with invalid params" do
      it "assigns the mensaje_usuario as @mensaje_usuario" do
        mensaje_usuario = MensajeUsuario.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MensajeUsuario.any_instance.stub(:save).and_return(false)
        put :update, {:id => mensaje_usuario.to_param, :mensaje_usuario => { "mensaje_id" => "invalid value" }}, valid_session
        assigns(:mensaje_usuario).should eq(mensaje_usuario)
      end

      it "re-renders the 'edit' template" do
        mensaje_usuario = MensajeUsuario.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MensajeUsuario.any_instance.stub(:save).and_return(false)
        put :update, {:id => mensaje_usuario.to_param, :mensaje_usuario => { "mensaje_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested mensaje_usuario" do
      mensaje_usuario = MensajeUsuario.create! valid_attributes
      expect {
        delete :destroy, {:id => mensaje_usuario.to_param}, valid_session
      }.to change(MensajeUsuario, :count).by(-1)
    end

    it "redirects to the mensaje_usuarios list" do
      mensaje_usuario = MensajeUsuario.create! valid_attributes
      delete :destroy, {:id => mensaje_usuario.to_param}, valid_session
      response.should redirect_to(mensaje_usuarios_url)
    end
  end

end
