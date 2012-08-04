

# Options
# * link_text - "some txt", defaults is nil

class Renderer::Link::Delete < Renderer::Link::Base
  
  # def initialize(template, url_in, options = {})
  #   super(template, options)
  # end

  def link_icon
    button? ? icon_delete_white : icon_delete
  end
  
  def link_text
    options[:link_text].presence
  end
  
  def data
    super.tap do |h|
      h[:confirmation] = confirmation
      # h[:row_id] = active_record_instance.try(:dom_id)
      # h[:format] = format
    end
  end
  
  def confirmation
    return '_none_' if options.has_key?(:confirm) && options[:confirm].blank?
    options[:confirm] || "Confirm the delete."
  end
  
  def classes
    super.tap do |ary|
      ary << 'delete-link'
      ary << 'btn-danger' if button?
    end
  end
  
end