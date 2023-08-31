module Resumes
  class UpdateService
    attr_accessor :user, :attributes, :current_resume_id

    def initialize(user:, params:)
      @user = user
      @attributes = resume_attributes(params)
      @current_resume_id = params[:current_resume_id]
    end

    def call!
      ActiveRecord::Base.transaction do
        # Guard against doing unnecessary work
        next if user.current_resume.id == current_resume_id && attributes[:resume].nil?
        # Updating the current resume is a two step process
        # First need to switch the current resume to false
        user.current_resume.update!(current: false)
        # If the resume was directly uploaded, create a new resume
        if attributes[:resume]
          user.resumes.create!(attributes)
          next
        end
        # Otherwise, update the existing resume
        user.resumes.find_by(id: current_resume_id).update!(current: true)
      end
    end

    private

    def resume_attributes(params)
      {
        resume: params[:resume].presence,
        name: params[:resume_name],
        current: true
      }
    end
  end
end
