# frozen_string_literal: true

class TableCellComponent < ViewComponent::Base
  def initialize(container_link: nil, hidden_on_mobile: false)
    @container_link = container_link
    @hidden_on_mobile = hidden_on_mobile
  end

  private

  attr_reader :container_link, :hidden_on_mobile
end
