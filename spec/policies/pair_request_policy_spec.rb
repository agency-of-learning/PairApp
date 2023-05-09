RSpec.describe PairRequestPolicy do
  subject { described_class }

  permissions :index?, :show? do
    it 'denies access if the user is not the author, invitee, or an admin account' do
      expect(subject).not_to permit(build(:user), build(:pair_request))
    end

    it 'grants access if the user is the author' do
      authoring_user = build(:user)
      expect(subject).to permit(authoring_user, build(:pair_request, author: authoring_user))
    end

    it 'grants access if the user is the invitee' do
      invitee_user = build(:user)
      expect(subject).to permit(invitee_user, build(:pair_request, invitee: invitee_user))
    end

    it 'grants access if the user is an admin' do
      admin = build(:user, :admin)
      expect(subject).to permit(admin, build(:pair_request))
    end
  end

  permissions :new?, :create? do
    it 'grants access to the user' do
      expect(subject).to permit(build(:user), build(:pair_request))
    end
  end

  permissions :accept? do
    context 'when the user is not the invitee' do
      it 'denies access' do
        authoring_user = build(:user)
        expect(subject).not_to permit(authoring_user, build(:pair_request, author: authoring_user))
      end
    end

    context 'when the user is the invitee' do
      let(:invitee) { build(:user) }

      it 'denies access if the request is expired/rejected' do
        expect(subject).not_to permit(invitee, build(:pair_request, invitee:, status: :expired))
      end

      it 'grants access if the user is the invitee and the request is pending' do
        expect(subject).to permit(invitee, build(:pair_request, invitee:))
      end
    end
  end

  permissions :reject? do
    context 'when the user is an the owner' do
      it 'denies access' do
        expect(subject).not_to permit(build(:user), build(:pair_request))
      end
    end

    context 'when the user is an owner' do
      let(:owner) { build(:user) }

      it "denies access if the request isn't accepted or pending" do
        expect(subject).not_to permit(
          owner,
          build(:pair_request, author: owner, status: :expired)
        )
      end

      it 'grants access if the request is pending/accepted' do
        expect(subject).to permit(owner, build(:pair_request, invitee: owner))
      end
    end
  end
end
