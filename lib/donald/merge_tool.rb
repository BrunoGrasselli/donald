module Donald
  class Donald::MergeTool
    DELIMITER = '******************************'
    
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
      system "vim -p #{files.join(' ')}"
    end
    
    def print_files files
      print_delimiter
      
      files.each {|f| puts f}
      
      print_delimiter
    end
    
    def print_no_files_message
      print_delimiter
      
      puts 'No unmerged files found'
      
      print_delimiter
    end
    
    def print_delimiter
      puts DELIMITER
    end
  end
end
