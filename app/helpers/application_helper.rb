# frozen_string_literal: true

# :nocov:
module ApplicationHelper
  include Pagy::Frontend
  # NOTE: move to specific datetime place (forget name)
  def pretty_datetime(timestamp)
    timestamp.strftime('%B %d, %Y at %l:%M %p')
  end

  # rubocop:disable Style/PerceivedComplexity
  def pagy_nav(pagy, pagy_id: nil, link_extra: '', **vars)
    p_id   = %[ id="#{pagy_id}"] if pagy_id
    link   = pagy_link_proc(pagy, link_extra:)
    p_prev = pagy.prev
    p_next = pagy.next

    html = +%[<nav#{p_id} class="isolate inline-flex -space-x-px shadow-sm">]
    html << if p_prev
              link.call(p_prev, pagy_t('pagy.nav.prev'),
                'aria-label="previous" class="btn rounded-none rounded-l-md"').to_s
            else
              %[<span class="btn btn-disabled rounded-none rounded-l-md">#{pagy_t('pagy.nav.prev')}</span> ]
            end
    pagy.series(**vars).each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << case item
              when Integer then %[#{link.call item, item, 'class="isolate btn rounded-none"'} ]
              when String  then %[<span class="isolate btn btn-active rounded-none">#{pagy.label_for(item)}</span> ]
              when :gap    then %[<span class="isolate gap rounded-none">...</span> ]
              else raise InternalError,
                "expected item types in series to be Integer, String or :gap; got #{item.inspect}"
              end
    end
    html << if p_next
              link.call(p_next, pagy_t('pagy.nav.next'), 'aria-label="next" class="btn rounded-none rounded-r-md"').to_s
            else
              %[<span class="btn rounded-none rounded-r-md btn-disabled">#{pagy_t('pagy.nav.next')}</span>]
            end
    html << %[</nav>]
  end
  # rubocop:enable Style/PerceivedComplexity

  def render_navbar
    if current_page?(root_path)
      render(partial: 'layouts/landing_navbar')
    else
      render partial: 'layouts/navbar'
    end
  end

  def background_color
    if current_page?(root_path)
      'bg-[#2C2E36]'
    end
  end
end
# :nocov:
