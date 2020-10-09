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
    print "Enter name: "
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

def change_settings
  puts "Do you want to change username or emoji?"
  input = gets.chomp.downcase

  if input == "username"
    print "Enter new username: "
    settings = gets.chomp
    tempHash = {
        "icon_emoji": nil,
        "username": settings
    }

  elsif input == "emoji"
    print "Enter new emoji: "
    settings = gets.chomp
    tempHash = {
        "icon_emoji": settings,
        "username": nil
    }
  end

  {
      "icon_emoji": settings
  }

  File.open("../bot_settings.json") do |file|
    file.write(settings.to_json)
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
    - QUIT

    Please enter a request:"
    input = gets.chomp.downcase

    case input
    when "list users"
      tp workspace.users, "id", "name", "real_name"

    when "list channels"
      tp workspace.channels, "id", "name", "topic", "member_count"

    when "select user"
      selected = find(workspace.users, workspace)
      puts selected.name if selected

    when "select channel"
      selected= find(workspace.channels, workspace)
      puts selected.name if selected

    when "details"
      begin
        puts workspace.show_details(selected)
      rescue ArgumentError
        print "No user or channel selected."
      end
    when "change settings"

    when "quit"
      puts "Thank you for using the Ada Slack CLI...exiting."
      exit

    else
      puts "Invalid choice."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME