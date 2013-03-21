require 'prawn'
require 'i18n'
require 'data_mapper'

require "label_gen/version"
require "label_gen/frame_iter"
require "label_gen/page"
require "label_gen/number_generator"
require "label_gen/number_record"
require "label_gen/qr_render"
require "label_gen/configuration"
require "label_gen/template"
require "label_gen/utils"

module LabelGen
  
  TEMPLATE_DIR = File.join(File.dirname(__FILE__), 'label_gen/template')

  DataMapper.finalize

end
