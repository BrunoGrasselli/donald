module Donald
  class MergeTool
    def initialize(output, args = [])
      @output = output
      @options = parse_options args
    end
    
    def start
      files = Donald::Git.new.conflicted_files
      
      if files.any?
        print_files files
        call_vim files
      else
        print_no_files_message
      end
    end
    
    private
    
    def call_vim(files)
      Kernel.system "#{editor}#{arguments(editor)} #{files.join(' ')}"
    end

    def editor
      @editor || @editor = Donald::Editor.new(@options[:editor])
    end
    
    def print_files(files)
      print_delimiter
      
      files.each {|f| @output.puts f}
      
      print_delimiter
    end
    
    def print_no_files_message
      print_delimiter
      
      @output.puts 'No unmerged files found'
      
      print_delimiter
    end
    
    def print_delimiter
      @output.puts '*' * 30
    end
    
    def parse_options(args)
      options = {}
      
      options.merge! :editor => 'vim' if args.include?('--vim')
      options.merge! :editor => 'mvim' if args.include?('-m') || args.include?('--mvim')
      options.merge! :editor => 'gvim' if args.include?('-g') || args.include?('--gvim')
      options.merge! :editor => 'mate' if args.include?('-t') || args.include?('--textmate')
      
      options
    end
    
    def arguments(editor)
      " #{tab_argument} #{search_argument}" if editor.to_s.include? 'vim'
    end
    
    def tab_argument
      '-p'
    end
    
    def search_argument
      '+/HEAD'
    end
  end
end
