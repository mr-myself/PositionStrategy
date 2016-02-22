class Twitter

  def self.build_user_parameters(auth)
    {
      name: auth['info']['nickname'],
      uid: auth['uid']
    }
  end
end
