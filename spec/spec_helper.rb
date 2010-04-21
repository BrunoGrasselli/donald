require File.expand_path(File.dirname(__FILE__) + '/../lib/donald/merge_tool')

def status_message_with_no_unmerged_files
  %{
    # On branch master
    nothing to commit (working directory clean)
  }
end

def status_message_with_unmerged_files unmerged_files, both_modified_files = []
  %{
    # Not currently on any branch.
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   app/models/user.rb
    #
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
#{file_lines(unmerged_files, 'unmerged')}
#{file_lines(both_modified_files, 'both modified')}
    #
  }
end

def file_lines(files, status)
  result = []
  
  files.each do |file|
    result << "    #       #{status}:   #{file}"
  end
  
  result.join(10.chr)
end
