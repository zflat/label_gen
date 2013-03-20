require 'thor'

module LabelGen
  class Utils < Thor
    
    desc "gen_pages", "Generates the next N pages of labels that are to be printed as PDF"
    #  method_option :n_pages, :type => :integer, :default => 1, :aliases => '-n', :desc => "The number of pages to be generated"
    method_option :path, :type => :string, :default => './pages.pdf', :desc => "Path where the generated PDF will be saved"
    def gen_pages(n_pages)
      path = options[:path]
      puts "Generating #{n_pages} pages of labels in #{path}" 
    end
    
  end
  
  # Utils.start
end
