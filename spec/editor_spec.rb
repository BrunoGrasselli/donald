require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Editor do
  context 'with no argument' do
    it 'should return the default editor' do
      Donald::Editor.new.to_s.should eql(Donald::Editor::DEFAULT_EDITOR)
    end
  end

  context 'with mate as editor argument' do
    it 'should return mate' do
      Donald::Editor.new('mate').to_s.should eql('mate')
    end
  end

  context 'with $EDITOR variable as gedit' do
    context 'with no argument' do
      it 'should return gedit' do
        editor = Donald::Editor.new
        editor.stub!(:system_editor_variable).and_return('mate')
        Donald::Editor.stub!(:new).and_return(editor)
        Donald::Editor.new('mate').to_s.should eql('mate')
      end
    end

    context 'with vim as argument' do
      it 'should return vim' do
        editor = Donald::Editor.new('vim')
        editor.stub!(:system_editor_variable).and_return('mate')
        Donald::Editor.stub!(:new).and_return(editor)
        Donald::Editor.new('mate').to_s.should eql('vim')
      end
    end
  end
end
