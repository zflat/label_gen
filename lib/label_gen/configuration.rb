module LabelGen

  # Allow for configuration in the host application
  # See http://robots.thoughtbot.com/post/344833329/mygem-configure-block
  class Configuration

    attr_accessor :template_name, :max_number_used, :output_path
    attr_reader :locale, :locale_path, :use_pdf_template
    
    def initialize
      @template_name = "Ol875"
      @use_pdf_template = false # option to copy pdf data from a template to new pages
      @max_number_used = 0
      @output_path = './output.pdf'
      self.locale = "en"
    end

    def qr_url=(format_str)
      I18n.backend.store_translations locale, :label_gen => {:qr_url => format_str}
    end

    def number_label=(format_str)
      I18n.backend.store_translations locale, :label_gen =>{:number_label => format_str}
    end

    # Setter method that updates the 
    # I18n locale
    def locale=(lang)
      @locale = lang
      set_locale_lang(@locale)
    end

    def template
      @template ||= LabelGen::Template.const_get(template_name).new
    end

    def cell
      LabelGen::Template.const_get(template_name)::Cell
    end

    private
    
    def set_locale_lang(lang)
      I18n.locale = lang
    end

    def remove_locale_load_path(path)
      return true if path.nil?
      I18n.load_path.delete(path)
    end

    def add_locale_load_path(path)
      I18n.load_path << path
      I18n.load_path.flatten!.uniq!
    end
  end
  
  class << self
    attr_accessor :configuration
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield(self.configuration)
  end
  
  def self.reset_configuration
    self.configuration = Configuration.new
  end
end
