class Facebook

  def self.build_user_parameters(auth)
    {
      name: auth['info']['name'],
      uid: auth['uid']
    }
  end
end
