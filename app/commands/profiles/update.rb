module Profiles
  class Update
    attr_accessor :user, :profile, :resume, :form

    def initialize(form:)
      @form = form
      @user = form.user
      @profile = form.profile
      @resume = form.resume
    end

    def call!
      status = :ok
      ActiveRecord::Base.transaction do
        update_profile!
        update_resume!
      rescue StandardError => e
        status = :unprocessable_entity
      end
      status
    end

    private

    def update_profile!
      profile.update!(profile_params)
    end

    def update_resume!
      user.resumes.update_all(current: false)
      return user.resumes.create!(new_resume_params) if form.resume

      user.resumes.find_by(id: current_resume_id)&.update!(current: true)
    end

    def profile_params
      form.attributes.slice('bio', 'job_search_status', 'location', 'name', 'title', 'picture')
    end

    def current_resume_id
      form.attributes['current_resume_id']
    end

    def new_resume_params
      {
        name: form.resume_name,
        resume: form.resume,
        current: true
      }
    end
  end
end
