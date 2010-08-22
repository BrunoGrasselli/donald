module Donald
  class Editor
    DEFAULT_EDITOR = 'vim'
    
    def initialize(name = nil)
      @name = name || Donald::Environment.editor_variable || DEFAULT_EDITOR
    end

    def run(files)
      Kernel.system "#{@name}#{arguments} #{files.join(' ')}"
    end

    private

    def arguments
      " #{tab_argument} #{search_argument}" if @name.include? 'vim'
    end
    
    def tab_argument
      '-p'
    end
    
    def search_argument
      '+/HEAD'
    end
  end
end
