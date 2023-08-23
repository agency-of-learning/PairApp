module LandingHelper
  def cta_button(text, icon_class)
    content_tag(
      :button,
      class: 'flex justify-between items-center w-full h-[70px] mb-4 ' \
             'bg-primary text-neutral font-bold px-4 rounded-lg ' \
             'hover:scale-105 transform transition-transform'
    ) do
      concat(text)
      concat(content_tag(:i, '', class: "fa-solid fa-arrow-right fa-lg color-neutral #{icon_class}"))
    end
  end
end
