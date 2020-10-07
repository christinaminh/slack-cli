require 'httparty'

require_relative 'workspace'


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  while true
    puts "What would you like to do?
    - LIST USERS
    - LIST CHANNELS
    - QUIT

    Please enter a request:"
    input = gets.chomp.downcase

    case input

    when "list users"
      puts workspace.users
    when "list channels"
      puts workspace.channels
    when "quit"
      puts "Thank you for using the Ada Slack CLI...exiting."
      exit
    else
      puts "Invalid choice."
    end
  end
end

main if __FILE__ == $PROGRAM_NAME