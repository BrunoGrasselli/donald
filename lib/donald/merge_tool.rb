module Donald
  class Donald::MergeTool
    DELIMITER = '******************************'
    DEFAULT_EDITOR = 'vim'
    
    def initialize output, args = []
      @output = output
      @options = parse_options args
    end
    
    def start
      files = unmerged_files git_status
      
      if files.any?
        print_files files
        
        call_vim files
      else
        print_no_files_message
      end
    end
    
    private
    
    def git_status
      `git status`
    end
    
    def unmerged_files text
      files = []
      
      text.each_line do |line|
        if line.match /unmerged: (.*)/
          files << $1.strip
        end
      end
      
      files
    end
    
    def call_vim files
      editor = @options[:editor] || DEFAULT_EDITOR
      
      Kernel.system "#{editor}#{tab_argument editor} #{files.join(' ')}"
    end
    
    def print_files files
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
      @output.puts DELIMITER
    end
    
    def parse_options args
      options = {}
      
      options.merge! :editor => 'mvim' if args.include?('-m') || args.include?('--mvim')
      options.merge! :editor => 'gvim' if args.include?('-g') || args.include?('--gvim')
      options.merge! :editor => 'mate' if args.include?('-t') || args.include?('--textmate')
      
      options
    end
    
    def tab_argument editor
      editor.include?('vim') ? ' -p' : ''
    end
  end
end
