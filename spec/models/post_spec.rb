require 'rails_helper'
include RandomData

RSpec.describe Post, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }

  it {is_expected.to have_many(:comments)}
  it {is_expected.to have_many(:votes)}
  it {is_expected.to have_many(:favorites)}
  it {is_expected.to belong_to(:topic)}
  it {is_expected.to belong_to(:user)}

  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:topic)}
  it {is_expected.to validate_presence_of(:user)}

  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(20)}

  context "attributes" do
    it "responds to title" do
      expect(post).to respond_to(:title)
    end

    it "responds to body" do
      expect(post).to respond_to(:body)
    end
  end

  context "voting" do
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes   = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect(post.up_votes).to eq(@up_votes)
      end
    end
    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect(post.down_votes).to eq(@down_votes)
      end
    end
    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect(post.points).to eq(@up_votes - @down_votes)
      end
    end
    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      end
      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1)
        expect(post.rank).to eq(old_rank + 1)
      end
      it "updates the rank when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: -1)
        expect(post.rank).to eq(old_rank - 1)
      end
    end

    describe "#create_vote" do
      it "sets the posts up_votes to 1" do
        post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        expect(post.up_votes).to eq(1)
      end
      it "calls #create_vote when a post is created" do
        post = topic.posts.new(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        expect(post).to receive(:create_vote)
        post.save
      end
      it "associates the vote with the owner of the post" do
        expect(post.votes.first.user).to eq(post.user)
      end
    end

    describe "#create_favorite" do
      it "calls #create_favorite when a post is created" do
        post = topic.posts.new(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        expect(post).to receive(:create_favorite)
        post.save
      end
      it "favorites own post automatically" do
        my_post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        expect(my_post.favorites.find_by(user_id: user.id)).to eq(my_post.favorites[0])
      end
    end
  end
end
