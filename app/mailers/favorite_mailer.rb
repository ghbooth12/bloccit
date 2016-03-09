class FavoriteMailer < ApplicationMailer
  default from: "ghbooth12@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@evening-fortress-95207.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@evening-fortress-95207.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@evening-fortress-95207.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
