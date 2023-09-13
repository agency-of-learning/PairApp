class MenteeApplicationStateForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :action, :string
  attribute :note, :string

  delegate :persisted?, :model_name, :to_param, to: :application_state

  attr_reader :action_options, :application_state, :current_status

  def initialize(current_state:, application_state:, params: {})
    @action_options = current_state.valid_transitions
    @current_status = current_state.status
    @application_state = application_state

    attributes = @application_state.attributes.slice(*self.class.attribute_names)
    super attributes.merge(params)
  end
end
