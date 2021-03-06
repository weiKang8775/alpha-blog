module ApplicationHelper
  def gravatar_for(user, size = 64)
    email_address = user.email.downcase
    hash = hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.username}'s profile picture", class: "rounded mx-auto d-block shadow")
  end
end
