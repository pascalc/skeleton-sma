require 'rubygems'
require 'data_mapper'

DataMapper.setup(:default, 'sqlite:///#{Dir.pwd}/db/user.db')

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, String
  property :userclass, String
  property :tagged, Integer

  def self.authenticate(email, password)
    puts "debugg"
    u = self.first(:email => email)
    puts "debugg"
    u && u.password == password ? u : nil
    puts "debugg"
  end

end

