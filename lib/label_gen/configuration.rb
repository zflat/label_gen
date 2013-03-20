module LabelGen

  # Allow for configuration in the host application
  # See http://robots.thoughtbot.com/post/344833329/mygem-configure-block
  class Configuration

    attr_accessor :default_template_name
    attr_reader :locale, :locale_path
    
    def initialize
      @default_template_name = "Ol875"
      self.locale_path = File.dirname(__FILE__) + '/../../locales'
      self.locale = "en"
    end

    # Setter method for the locale path
    # that updates the I18n load path
    def locale_path=(str)
      @locale_path = str
      add_locale_load_path(@locale_path)
    end

    # Setter method that updates the 
    # I18n locale
    def locale=(lang)
      @locale = lang
      set_locale_lang(@locale)
    end

    def default_template
      @def_template ||= LabelGen::Template.const_get(default_template_name).new
    end

    private
    
    def set_locale_lang(lang)
      I18n.locale = lang
    end

    def add_locale_load_path(path)
      I18n.load_path << Dir[File.join(File.expand_path(path), '*.yml')]
      I18n.load_path.flatten!
      puts I18n.load_path
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
