class InvitationsController < Devise::InvitationsController
  before_action -> { authorize :invitation }

  # PUT /users/invitation
  def update
    super { |resource| resource.profile.update(slug: resource.full_name.parameterize) }
  end
end
