# frozen_string_literal: true

class TabsComponent < ViewComponent::Base
  renders_many :tab_links
  renders_one :active_panel
  renders_many :panels
end
