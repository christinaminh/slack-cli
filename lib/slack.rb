require 'httparty'
require 'table_print'

require_relative 'workspace'

def find(dataset, workspace)
  print "Would you like to enter a name or id? "
  input = gets.chomp.downcase
  if input == "name"
    print "Enter name: "
    input = gets.chomp.downcase

    puts workspace.select(dataset: dataset ,name: input)
  elsif input == "id"
    print "Enter id: "
    input = gets.chomp.upcase

    puts workspace.select(dataset: dataset ,id: input)
  end

  rescue ArgumentError => error_message
    puts "Encountered an error: #{error_message}"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  while true
    puts "What would you like to do?
    - LIST USERS
    - LIST CHANNELS
    - SELECT USER
    - SELECT CHANNEL
    - QUIT

    Please enter a request:"
    input = gets.chomp.downcase

    case input

    when "list users"
      tp workspace.users, "id", "name", "real_name"
    when "list channels"
      tp workspace.channels, "id", "name", "topic", "member_count"
    when "select user"
      puts find(workspace.users, workspace)
    when "select channel"
      puts find(workspace.channels, workspace)
    when "quit"
      puts "Thank you for using the Ada Slack CLI...exiting."
      exit
    else
      puts "Invalid choice."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME