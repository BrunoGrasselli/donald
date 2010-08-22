module Donald
  class MergeTool
    def initialize(output, args = [])
      @printer = Donald::Printer.new output
      @editor = Donald::Editor.new(args.first)
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
  end
end
