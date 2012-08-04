class Renderer::Link::Base < Renderer::Base
  
  attr_accessor :url_in
  
  def initialize(template, url_in, options = {})
    super(template, options)
    self.url_in = url_in
  end
  
  def url
    @url ||= if url_in.is_a?(String)
      url_in
    else
      polymorphic_path(url_in)
    end
  end
  
  def html
    link_to(label, url, link_options)
  end
  
  def label
    [link_icon, link_text].safe_join(' '.html_safe)
  end
  
  # def link_icon
  #   button? ? App.icon_trash(:white) : App.icon_trash
  # end
  # 
  # def link_text
  #   options[:label] || t('button.delete')
  # end
  
  def link_options
    Hash.new.tap do |opts|
      opts[:id] = dom_id
      opts[:class] = classes
      opts[:data] = data
      opts[:title] = options[:title]
    end
  end
  
  def data
    Hash.new.tap do |h|
      h[:row_id] = active_record_instance.try(:dom_id)
      h[:format] = format
    end
  end
  
  # def confirmation
  #   return '_none_' if options.has_key?(:confirm) && options[:confirm].blank?
  #   options[:confirm] || "Confirm the delete"
  # end
  
  def dom_id
    if options[:id]
      options[:id]
    else
      dom_id_from_url
    end
  end
  
  def format
    fmt = options[:format].to_s.downcase
    ['ajax', 'js', 'javascript'].include?(fmt) ? 'js' : 'html'
  end
  
  def dom_id_from_url
    return active_record_instance.dom_id(action) if active_record_instance
    
    parts = url_in.to_s.split(/\/|\?/).reverse
    parts.each { |part| return "#{action}_#{part}" if part =~ /^\d+$/ }
    nil
  end
  
  def action
    self.class.demodulize_underscore.gsub(/_link$/, '')
  end
  
  # Tries to get an ActiveRecord instance from url_in parameter
  def active_record_instance
    @active_record_instance ||= 
      options[:active_record_instance] ||
      options[:ari] ||
      Array(url_in).reverse.detect { |e| e.kind_of?(ActiveRecord::Base) }
  end
  
  def classes
    Array.new.tap do |ary|
      ary << 'btn' if button?
    end
  end
  
  def button?
    options[:button]
  end
  
end