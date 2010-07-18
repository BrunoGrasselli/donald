module Donald
  class Git
    def unmerged_files
      ls_files.split("\n")
    end
    
    private
    
    def ls_files
      `git ls-files --unmerged | cut -f2 | sort -u`
    end
  end
end
