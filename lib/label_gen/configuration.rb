module LabelGen

  # Allow for configuration in the host application
  # See http://robots.thoughtbot.com/post/344833329/mygem-configure-block
  class Configuration

    attr_accessor :template_name, :max_number_used
    attr_reader :locale, :locale_path
    
    def initialize
      @template_name = "Ol875"
      @max_number_used = 1339
      self.locale_path = File.dirname(__FILE__) + '/../../locales'
      self.locale = "en"
    end

    # Setter method for the locale path
    # that updates the I18n load path
    def locale_path=(path)
      remove_locale_load_path(@locale_path)
      @locale_path = Dir[File.join(File.expand_path(path), '*.yml')]
      add_locale_load_path(@locale_path)
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
