module UsersHelper
  def has_post_or_comment?(user)
    user.posts.any? || user.comments.any?
  end

  def has_favorites?(user)
    user.favorites.any?
  end

  def array_of_favorited_posts(user)
    user.favorites.map {|favorite| Post.find(favorite[:post_id]) }
  end
end
