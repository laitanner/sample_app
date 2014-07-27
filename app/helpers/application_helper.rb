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

  # Returns the user name in correct message format ex: "Michael Hartl" -> "d1-michael-hartl"
  def user_name_message(user)
    downcased_name = user.name.downcase
    prefix_string = "d" + user.id.to_s + "-"
    
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

  # Creates message if micropost is intended to be a direct message
  def make_message(user, micropost)
    if (micropost.message_recipient != 0)
      send_out = user.sent_messages.build(content: micropost.content, addresser_id: user.id, addressee_id: micropost.message_recipient)
      send_out.save
      receiving_user = User.find(micropost.message_recipient)
      coming_in = receiving_user.received_messages.build(content: micropost.content, addresser_id: user.id, addressee_id: micropost.message_recipient)
      coming_in.save
    else
      return nil
    end
  end
end