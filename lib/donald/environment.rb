module Donald
  class Environment
    def self.editor_variable
      editor = system_variable('EDITOR').chomp
      editor.size.zero? ? nil : editor
    end

    private

    def self.system_variable(name)
      `echo $#{name}`
    end
  end
end
