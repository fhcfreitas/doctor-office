require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:published_post) { create(:post, :published) }
  let(:draft_post) { create(:post, :draft) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(published_post).to be_valid
      expect(draft_post).to be_valid
    end

    it "is not valid without a title" do
      published_post.title = nil
      expect(published_post).not_to be_valid
    end

    it "is not valid without content" do
      published_post.content = nil
      expect(published_post).not_to be_valid
    end

    it "belongs to a user" do
      expect(published_post.user).not_to be_nil
    end
  end

  describe "scopes" do
    it "returns published posts" do
      published_post
      draft_post
      expect(Post.published).to include(published_post)
      expect(Post.published).not_to include(draft_post)
    end

    it "returns drafted posts" do
      published_post
      draft_post
      expect(Post.drafted).to include(draft_post)
      expect(Post.drafted).not_to include(published_post)
    end
  end

  describe "callbacks" do
    it "sets published_at when publishing a post" do
      post = create(:post, draft: true, published_at: nil)
      post.publish!
      expect(post.published_at).not_to be_nil
    end

    it "does not change published_at when updating a published post" do
      post = create(:post, :published)
      original_published_at = post.published_at
      post.update(title: "Updated Title")
      expect(post.published_at).to eq(original_published_at)
    end
  end
end
