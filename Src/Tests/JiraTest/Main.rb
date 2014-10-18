require 'pp'
require 'jira'
require 'rubygems'



options = {
            :username => '1',
            :password => '1',
            :site     => 'https://jira.wargaming.net/',
            :context_path => '',
            :auth_type => :basic,
            :use_ssl => false
          }

client = JIRA::Client.new( options )

# Show all projects
projects = client.Project.all

projects.each do |project|
  puts "Project -> key: #{project.key}, name: #{project.name}"
end
