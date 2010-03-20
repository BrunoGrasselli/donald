module Donald
  class Donald::MergeTool
    def git_status
      `git status`
    end
    
    def unmerged_files text
      files = []
      
      text.each_line do |line|
        if line.match /deleted: (.*)/
          files << $1.strip
        end
      end
      
      files
    end
    
    def call_vim files
      puts "vim -p #{files.join(' ')}" if files.any?
    end
  end
end
