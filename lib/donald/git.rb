module Donald
  class Git
    CONFLICTED_TYPES = ['unmerged', 'both modified', 'both added']

    def conflicted_files
      files = []
      
      status.each_line do |line|
        file = conflicted_file(line)
        files << file unless file.nil?
      end
      
      files
    end
    
    def status
      `git status`
    end

    private
    
    def conflicted_file(line)
      CONFLICTED_TYPES.each do |conflicted_type|
        if line.match /#{conflicted_type}: (.*)/
          return $1.strip
        end
      end
      
      nil
    end
  end
end
