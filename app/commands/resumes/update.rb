module Resumes
  class Update
    attr_accessor :user, :params, :current_resume_id

    def initialize(user:, params:)
      @user = user
      @params = cast_to_attributes(params)
      @current_resume_id = params[:current_resume_id]
    end

    def call!
      update_resume!
    end

    private

    def update_resume!
      user.resumes.update_all(current: false)
      return user.resumes.create!(params) if params[:resume]

      user.resumes.find_by(id: current_resume_id)&.update!(current: true)
    end

    def cast_to_attributes(params)
      {
        resume: params[:resume],
        name: params[:resume_name],
        current: true
      }
    end
  end
end
