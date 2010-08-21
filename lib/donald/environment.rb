module Donald
  class Environment
    def self.editor_variable
      editor = `echo $EDITOR`
      editor.chomp.size.zero? ? nil : editor
    end
  end
end
