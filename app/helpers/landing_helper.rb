module LandingHelper
  def cta_button(text, route)
    link_to(
      route,
      class: 'flex justify-between items-center w-full h-[70px] mb-4 ' \
             'bg-primary text-neutral font-bold px-4 rounded-lg ' \
             'hover:scale-105 transform transition-transform'
    ) do
      concat(text)
      concat(tag.i(class: 'fa-solid fa-arrow-right fa-lg color-neutral color-neutral'))
    end
  end
end
