module MicropostsHelper
  def like
    current_user.active_likes.build
  end

  def unlike
    current_user.active_likes.find_by micropost_id: micropost.id
  end
end
