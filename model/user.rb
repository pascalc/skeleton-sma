require 'rubygems'
require 'data_mapper'

#DataMapper.setup(:default, 'sqlite:///#{Dir.pwd}/db/user.db')
a = DataMapper.setup(:default, "sqlite:db/user.db")

register Warden

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password, String
  property :userclass, String
  property :tagged, Integer

  def self.authenticate(email, password)
    u = self.first(:email => email)
    u && u.password == password ? u : nil
  end

end

