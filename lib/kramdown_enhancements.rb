module Kramdown
  module Converter
    class Html
      def convert_blockquote(el, indent)
        first_child = el.children[0]

        case first_child.to_h
        in {
          type: :p,
          children: [
            { type: :text, value: /\A\[!(CAUTION|IMPORTANT|NOTE|TIP|WARNING)\]\z/ },
            { type: :br },
            *
          ]
        }
          # The matching regular expression group.
          alert_type = $+.downcase

          # Remove the alert type text and trailing <br>.
          first_child.children.slice!(0, 2)

          header = Element.new(:html_element, :h1, { class: 'alert-heading' })
          header.children << Element.new(
            :img,
            nil,
            {
              alt: '', # This image is purely decorative.
              src: "/images/#{alert_type}.svg",
            }
          )
          header.children << Element.new(:text, alert_type.capitalize)

          aside = Element.new(:html_element, :aside)
          aside.children << header
          aside.children.push(*el.children)

          format_as_block_html(
            'aside',
            { class: "alert alert-#{alert_type}" },
            format_as_indented_block_html(
              'div',
              {},
              inner(aside, indent),
              indent
            ),
            indent
          )
        else
          # super.
          format_as_indented_block_html('blockquote', el.attr, inner(el, indent), indent)
        end
      end
    end
  end

  class Element
    def to_h
      {
        children: children.map(&:to_h),
        type:,
        value:
      }
    end
  end
end
