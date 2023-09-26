require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProfilesHelper. For example:
#
# describe ProfilesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProfilesHelper do
  describe '#profile_picture_tag' do
    context "when the profile doesn't exist" do
      it 'returns nil' do
        expect(profile_picture_tag(nil, variant: :icon)).to be_nil
      end
    end

    context 'when the profile has an attached picture' do
      let(:profile_with_picture) { build(:profile, picture: true) }

      it 'returns an image tag with the attached file src' do
        attachment_filename = profile_with_picture.picture.filename.to_s
        expect(profile_picture_tag(profile_with_picture, variant: :icon)).to include(attachment_filename)
      end
    end

    context 'when the profile does not have an attached picture' do
      let(:profile) { build(:profile) }

      it 'returns an image with the placeholder src' do
        expect(profile_picture_tag(profile, variant: :icon)).to include('placeholder_profile_picture')
      end
    end
  end
end
