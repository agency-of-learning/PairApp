# frozen_string_literal: true

class TableCellComponent < ViewComponent::Base
  def initialize(container_link: nil, class_names: 'table-cell')
    @container_link = container_link
    @class_names = class_names
  end

  private

  attr_reader :container_link, :class_names
end
