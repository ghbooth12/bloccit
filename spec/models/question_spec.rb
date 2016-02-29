require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {Question.create!(title: "New Question Title", body: "New question body", resolved: false)}

  describe "attributes" do
    it "responds to the title" do
      expect(question).to respond_to(:title)
    end
    it "responds to the body" do
      expect(question).to respond_to(:body)
    end
    it "responds to the resolved" do
      expect(question).to respond_to(:resolved)
    end
  end
end
