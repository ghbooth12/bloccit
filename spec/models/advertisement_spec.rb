require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:ad) {Advertisement.create!(title: "Advertisement Title", copy: "This is Advertisement Copy", price: 100)}

  describe "attributes" do
    it "responds to title" do
      expect(ad).to respond_to(:title)
    end
    it "responds to copy" do
      expect(ad).to respond_to(:copy)
    end
    it "responds to price" do
      expect(ad).to respond_to(:price)
    end
  end
end
