class UserApiModel
    attr_accessor :username
    
    def initialize(user)
      @username = user.username
    end
  end