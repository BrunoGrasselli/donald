module Donald
  class Editor
    DEFAULT_EDITOR = 'vim'
    
    def initialize(editor_name = nil)
      @editor_name = editor_name
    end

    def to_s
      @editor_name || system_editor_variable || DEFAULT_EDITOR
    end

    private
    
    def system_editor_variable
      editor = `echo $EDITOR`
      editor.chomp.size.zero? ? nil : editor
    end
  end
end
