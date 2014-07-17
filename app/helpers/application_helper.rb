	module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # Returns the user name in correct reply format ex: "Michael Hartl" -> "@1-michael-hartl"
  def user_name_reply(user)
    downcased_name = user.name.downcase
    prefix_string = "@" + user.id.to_s + "-"
    
    # if there are no spaces
    if downcased_name.match(/\s/) == nil
      return prefix_string + downcased_name
    end
    
    # create a name string ex: "Michael Hartl" -> "michael-hartl"
    name_string = ""
    str_index = 0
    while downcased_name.index(' ', str_index) != nil
      name_string = name_string + downcased_name[str_index..downcased_name.index(' ') - 1] + "-"
      str_index = downcased_name.index(' ') + 1
    end
    name_string = name_string + downcased_name[str_index..downcased_name.length - 1]
    
    return prefix_string + name_string
  end
end