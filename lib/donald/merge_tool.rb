module Donald
  class MergeTool
    DEFAULT_EDITOR = 'vim'
    CONFLICTED_TYPES = ['unmerged', 'both modified', 'both added']
    
    def initialize(output, args = [])
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
    
    def unmerged_files(text)
      files = []
      
      text.each_line do |line|
        file = conflicted_file(line)
        files << file unless file.nil?
      end
      
      files
    end
    
    def conflicted_file(line)
      CONFLICTED_TYPES.each do |conflicted_type|
        if line.match /#{conflicted_type}: (.*)/
          return $1.strip
        end
      end
      
      nil
    end
    
    def call_vim(files)
      Kernel.system "#{editor}#{arguments(editor)} #{files.join(' ')}"
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
    
    def editor
      @options[:editor] || system_editor_variable || DEFAULT_EDITOR
    end
    
    def system_editor_variable
      `echo $EDITOR`.chomp.size.zero? ? nil : editor
    end
    
    def arguments(editor)
      " #{tab_argument} #{search_argument}" if editor.include? 'vim'
    end
    
    def tab_argument
      '-p'
    end
    
    def search_argument
      '+/HEAD'
    end
  end
end
