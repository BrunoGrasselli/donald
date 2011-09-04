module Donald
  class MergeTool
    def initialize(output, args = [])
      @printer = Donald::Printer.new output
      @editor = Donald::Editor.new(args.first)
    end

    def start
      unmerged_files.any? ? process_files : print_no_files_message
    end

    private

    def unmerged_files
      @unmerged_files ||= Donald::Git.new.unmerged_files
    end

    def process_files
      @printer.print_files unmerged_files
      @editor.run unmerged_files
    end

    def print_no_files_message
      @printer.print_no_files_message
    end
  end
end
