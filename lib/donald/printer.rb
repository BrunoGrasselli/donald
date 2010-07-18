module Donald
  class Printer
    def initialize(output)
      @output = output
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
  end
end
