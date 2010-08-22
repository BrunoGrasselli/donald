module Donald
  class MergeTool
    def initialize(output, args = [])
      @printer = Donald::Printer.new output
      @options = parse_options args
      @editor = Donald::Editor.new(@options[:editor])
    end
    
    def start
      files = Donald::Git.new.unmerged_files
      
      if files.any?
        @printer.print_files files
        @editor.run files
      else
        @printer.print_no_files_message
      end
    end
    
    private
    def parse_options(args)
      options = {}
      
      options.merge! :editor => 'vim' if args.include?('--vim')
      options.merge! :editor => 'mvim' if args.include?('-m') || args.include?('--mvim')
      options.merge! :editor => 'gvim' if args.include?('-g') || args.include?('--gvim')
      options.merge! :editor => 'mate' if args.include?('-t') || args.include?('--textmate')
      
      options
    end
  end
end
