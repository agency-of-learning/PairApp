class AdminConstraint
  def self.matches?(request)
    return false if request.session['warden.user.user.key'].blank?

    user_id, _key = request.session['warden.user.user.key']

    user = User.find(user_id)
    user.admin?
  end
end
