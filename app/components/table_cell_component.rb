# frozen_string_literal: true

class TableCellComponent < ViewComponent::Base
  def initialize(container_link: nil, classes: nil)
    @container_link = container_link
    @classes = classes
  end

  private

  attr_reader :container_link, :classes
end
