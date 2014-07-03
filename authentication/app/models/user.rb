class User
  attr_accessor :username, :password

  USERS = ["user1", "user2"]

  def initialize(username)
    @username = username
    @password = username.reverse
  end

  def self.find(username)
    if USERS.include?(username)
      User.new(username)
    end
  end

  def autenticate(password)
    @password == password
  end
end
