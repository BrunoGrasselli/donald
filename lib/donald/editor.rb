module Donald
  class Editor
    DEFAULT_EDITOR = 'vim'
    
    def initialize(editor_name = nil)
      @editor_name = editor_name
    end

    def to_s
      @editor_name || Donald::Environment.editor_variable || DEFAULT_EDITOR
    end
  end
end
