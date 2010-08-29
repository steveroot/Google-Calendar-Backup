# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("1m") do
  logger.debug "I ran a rufus schedule"
   #Snapshots.parse
end
