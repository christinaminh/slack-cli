require 'httparty'
require 'table_print'
require 'json'

require_relative 'workspace'

def find(dataset, workspace)
  print "Would you like to enter a name or id? "
  input = gets.chomp.downcase

  until input == "name"|| input == "id"
    puts "Please enter 'name' or 'id': "
    input = gets.chomp.downcase
  end

  if input == "name"
    if dataset[0].instance_of? User
      print "Enter username: "
    elsif dataset[0].instance_of? Channel
      print"Enter channel name: "
    end

    input = gets.chomp.downcase

    return workspace.select(dataset: dataset ,name: input)

  elsif input == "id"
    print "Enter id: "
    input = gets.chomp.upcase

    return workspace.select(dataset: dataset ,id: input)
  end

  rescue ArgumentError => error_message
    puts "Encountered an error: #{error_message}\n\n"
end

def message
  print "Enter message => "
  message = gets.chomp

  if message.empty?
    puts "Invalid message (no content). Please enter a VALID message or hit 'ENTER' to return to main menu. => "
    message = gets.chomp.downcase
  end

  return message
end

def change_settings
  settings_json = File.read("bot_settings.json")
  settings = JSON.parse(settings_json)

  puts "Do you want to change username or emoji?"
  input = gets.chomp.downcase

  if input == "username"
    print "Enter new username: "
    new_setting = gets.chomp

    settings["username"] = new_setting
    File.write("bot_settings.json", settings.to_json)

  elsif input == "emoji"
    print "Enter new emoji: "
    new_setting = gets.chomp

    settings["icon_emoji"] = new_setting
    File.write("bot_settings.json", settings.to_json)
  end

end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  while true
    puts "\nWhat would you like to do?
    - LIST USERS
    - LIST CHANNELS
    - SELECT USER
    - SELECT CHANNEL
    - DETAILS
    - SEND MESSAGE
    - CHANGE SETTINGS
    - QUIT"

    print "\nPlease enter a request: "
    input = gets.chomp.downcase

    case input
    when "list users"
      tp workspace.users, "id", "name", "real_name"

    when "list channels"
      tp workspace.channels, "id", "name", "topic", "member_count"

    when "select user"
      selected = find(workspace.users, workspace)
      puts "You've selected '#{selected.name}'!" if selected

    when "select channel"
      selected= find(workspace.channels, workspace)
      puts "You've selected '#{selected.name}'!" if selected

    when "details"
      if selected
        puts workspace.show_details(selected)
      else
        puts "No user or channel selected.\n"
      end
    when "change settings"
      change_settings
    when "send message"
      begin
        if selected
          workspace.send_message(selected, message)
        else
          puts "No user or channel selected.\n"
        end
      rescue NoMessageError
        puts "No message entered."
      rescue SlackApiError => error_message
        puts "Encountered an error: #{error_message}\n\n"
      end

    when "quit"
      puts "\n👋 👋 Thank you for using the Ada Slack CLI...exiting."
      exit

    else
      puts "Invalid choice."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME