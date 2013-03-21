require 'thor'

module LabelGen
  class Utils < Thor
    
    desc "gen_pages N", "Generates the next N pages of labels as a PDF"
    method_option :path, 
    :type => :string, :default => './pages.pdf', 
    :desc => "Path where the generated PDF will be saved"
    def gen_pages(n_pages)
      path = options[:path]
      puts "Generating #{n_pages} pages of labels in #{path}" 
    end

    desc "gen_labels N", "Generates the next N labels rendered to PDF"
    method_option :path, 
    :type => :string, :default => './pages.pdf', 
    :desc => "Path where the generated PDF will be saved"
    def gen_labels(n_labels)
      path = options[:path]
      
    end

    desc "confirm_printed MAX_NUMBER", "Update the highest number printed with MAX_NUMBER"
    def confirm_printed(max_number)
      
    end

    desc "current_max_number", "Get the value of the max number that has been confirmed as printed"
    def current_max_number
      puts NumberRecord.max_number_confirmed
    end
    
  end
  
  # Utils.start
end
