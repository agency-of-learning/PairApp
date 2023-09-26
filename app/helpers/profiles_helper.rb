module ProfilesHelper
  def profile_picture_tag(profile, variant:, **opts)
    return if profile.blank?

    src = if profile.picture.attached?
            profile.picture.variant(variant)
          else
            'placeholder_profile_picture.png'
          end

    image_tag src, opts
  end
end
