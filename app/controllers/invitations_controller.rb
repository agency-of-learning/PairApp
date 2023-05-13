class InvitationsController < Devise::InvitationsController
  before_action -> { authorize :invitation }
end
