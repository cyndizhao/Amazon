require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) {FactoryGirl.create(:product)}
  let(:product_1) {FactoryGirl.create(:product)}
  describe '#Index action' do
    it 'assigns a variable for all products' do
      product
      product_1
      get :index
      expect(assigns(:products)).to eq(Product.last(20))
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#show action' do
    it 'assigns a varible for the product with the passed in id' do
      get :show, params:{id:product.id}
      expect(assigns(:product)).to eq(product)
    end

    it'renders the show template' do
      get :show, params:{id:product.id}
      expect(response).to render_template(:show)
    end
  end

  describe '#new action' do
    it 'assigns a instance variable ' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  describe '#create action' do
    context 'with valid attributes' do
      def valid_request
        post :create, params: {product: FactoryGirl.attributes_for(:product)}
      end
      it 'create a new instance for Product in the database' do
        count_before = Product.count
        valid_request
        count_after = Product.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'set a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end

      it 'redirect to the product show page' do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {product: FactoryGirl.attributes_for(:product, title:nil)}
      end
      it 'does not create a new product in the database' do
        count_before = Product.count
        invalid_request
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end

      it 'renders a new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end

  end

  describe '#Edit action' do
    it 'assigns a varible for the product with the passed in id' do
      get :edit, params:{id:product_1.id}
      expect(assigns(:product)).to eq(product_1)
    end

    it 'render product edit page' do
      get :edit, params:{id:product_1.id}
      expect(response).to render_template(:edit)
    end
  end

  describe '#Update action' do
    context 'with valid attributes' do
      def valid_request
        patch :update, params: {
          id: product_1.id, product: FactoryGirl.attributes_for(:product, title: 'Cyndi is smart.')
        }
      end

      it 'assigns a varible for the product with the passed in id' do
        valid_request
        expect(assigns(:product)).to eq(product_1)
      end

      it "updates the value of the product" do
        valid_request
        expect(product_1.reload.title).to eq('Cyndi is smart.')
      end

      it 'redirect_to product show page' do
        valid_request
        expect(response).to redirect_to(product_path(product_1))
      end
    end
  end

  describe '#destroy action' do
    it 'remove the product from database' do
      product
      product_1
      count_before = Product.count
      delete :destroy, params:{ id: product_1.id }
      count_after = Product.count
      expect(count_after).to eq(count_before - 1)
    end
  end
  
end
