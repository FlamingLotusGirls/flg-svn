
require 'rubygems'
require 'serialport'
require 'yaml'
require 'active_record'
require 'logger'

PROJECT_HOME = "#{ENV['HOME']}/flg/tympani/driver/"
require "#{PROJECT_HOME}/app/models/poofer.rb"
require "#{PROJECT_HOME}/app/models/poofer_sequence.rb"
require "#{PROJECT_HOME}/app/models/sequence.rb"

ActiveRecord::Base.logger = Logger.new( STDERR )
db_config = YAML::load( File.open("#{PROJECT_HOME}/config/database.yml"))
ActiveRecord::Base.establish_connection( db_config["development"])

chase = Sequence.new()
#chase.poofers = [
#                Poofer.new(1,1),
#                Poofer.new(1,2),
#                Poofer.new(1,3),
#                Poofer.new(1,4),
#                Poofer.new(1,5),
#                Poofer.new(1,6),
#                Poofer.new(1,7),
#                Poofer.new(1,8),
#                Poofer.new(2,1),
#                Poofer.new(2,2),
#                Poofer.new(2,3),
#                Poofer.new(2,4),
#                Poofer.new(2,5),
#                Poofer.new(2,6),
#                Poofer.new(2,7),
#                Poofer.new(2,8),
#                ]
#chase.delay = 150


while true do
  begin
    sp = SerialPort.new "/dev/tty.usbserial-FTCSF3TA", 19200
  rescue
    puts "error #{$!}"
  end
#  chase.poofer.each do |poofer|
#    outputString = "!0" + poofer.board.to_s + poofer.relay.to_s + "1" + "."
#    puts outputString
    begin
#      sp.write outputString
    rescue
      puts "serial error #{$!}"
    end
#    sleep chase.delay / 1000.0 
#  end
end
