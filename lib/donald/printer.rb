module Donald
  class Printer
    def initialize(output)
      @output = output
    end

    def print_files(files)
      print_delimiter do
        files.each {|f| @output.puts f}
      end
    end
    
    def print_no_files_message
      print_delimiter do
        @output.puts 'No unmerged files found'
      end
    end
    
    private

    def print_delimiter
      print_single_delimiter
      if block_given?
        yield
        print_single_delimiter
      end
    end

    def print_single_delimiter
      @output.puts '*' * 30
    end
  end
end
