module Auth0Helper
  def mock_auth0(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:auth0] = OmniAuth::AuthHash.new({
      provider: 'auth0',
      uid: user.id,
      info: {
        email: user.email,
        time_zone: user.time_zone
      },
      credentials: {
        token: 'fake_auth0_token'
      },
      extra: {
        raw_info: {
          uid: user.id,
          email: user.email,
          time_zone: user.time_zone,
        }
      }
    })
  end
end