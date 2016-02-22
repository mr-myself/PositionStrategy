class UserFactory

  class << self
    def via_sns(auth)
      user_factory = new(auth['provider'])
      user_factory.create(auth)
    end
  end

  def initialize(provider)
    @provider = provider
  end

  def create(auth)
    user = User.new(@provider.classify.constantize.build_user_parameters(auth))
    user.save ? user : false
  end
end
