class AdminConstraint
  def self.matches?(request)
    return false if request.session['warden.user.user.key'].blank?

    user_id_array, _key = request.session['warden.user.user.key']
    user_id = user_id_array.first

    user = User.find(user_id)
    user.admin?
  end
end
