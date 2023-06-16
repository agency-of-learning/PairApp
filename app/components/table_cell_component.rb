# frozen_string_literal: true

class TableCellComponent < ViewComponent::Base
  def initialize(container_link: nil)
    @container_link = container_link
  end

  private

  attr_reader :container_link
end
