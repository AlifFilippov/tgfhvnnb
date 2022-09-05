module ApplicationHelper
  def display_links
    if @auth
      link_to("LOGOUT", logout_path, :method => :delete) +
      link_to("MY EVENTS", events_path)
    else
      link_to("LOGIN", login_path) +
      link_to("REGISTER", register_path)
    end
  end
end
