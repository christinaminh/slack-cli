require 'httparty'

require_relative 'workspace'


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  # if input is list users
  return workspace.users
  # if input is list channels
  return workspace.channels
  # else quit

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME