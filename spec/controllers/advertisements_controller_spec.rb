require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:my_ad) {Advertisement.create!(title: "Advertisement Title", copy: "This is Advertisement Copy", price: 100)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns my_ad to @ads" do
      get :index
      expect(assigns(:ads)).to eq([my_ad])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template("new")
    end
    it "instantiates @ad" do
      get :new
      expect(assigns(:ad)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increases the number of Advertisement by 1" do
      expect{
        post :create,
        advertisement: {title: "Advertisement Title", copy: "This is Advertisement Copy", price: 100}
      }.to change(Advertisement, :count).by(1)
    end
    it "assigns the new advertisement to @advertisement" do
      post :create,
      advertisement: {title: "Advertisement Title", copy: "This is Advertisement Copy", price: 100}
      expect(assigns(:advertisement)).to eq(Advertisement.last)
    end
    it "redirects to the new advertisement" do
      post :create,
      advertisement: {title: "Advertisement Title", copy: "This is Advertisement Copy", price: 100}
      expect(response).to redirect_to(Advertisement.last)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_ad.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: my_ad.id}
      expect(response).to render_template("show")
    end
    it "assigns my_ad to @advertisement" do
      get :show, {id: my_ad.id}
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end
end
