require "label_gen/template/ol875"

module LabelGen
  module Template
    def self.label(number)
      I18n.translate('label_gen.number_label', :number => number)
    end
  end
end
