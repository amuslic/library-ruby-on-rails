class UserApiModel
    attr_accessor :username, :role
    
    def initialize(user)
      @username = user.username
      @role = user.role
    end
  end