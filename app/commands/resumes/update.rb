module Resumes
  class Update
    attr_accessor :user, :attributes, :current_resume_id

    def initialize(user:, params:)
      @user = user
      @attributes = attributes(params)
      @current_resume_id = params[:current_resume_id]
    end

    def call!
      ActiveRecord::Base.transaction do
        # rubocop:disable Rails::SkipsModelValidations
        user.resumes.update_all(current: false)
        # rubocop:enable Rails::SkipsModelValidations
        if attributes[:resume]
          user.resumes.create!(attributes)
          next
        end

        user.resumes.find_by(id: current_resume_id).update!(current: true)
      end
    end

    private

    def attributes(params)
      {
        resume: params[:resume],
        name: params[:resume_name],
        current: true
      }
    end
  end
end
