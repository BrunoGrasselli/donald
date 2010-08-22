require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Editor do
  context 'with $EDITOR variable not seted up' do
    before :each do
      Donald::Environment.stub!(:editor_variable).and_return(nil)
    end

    context 'with no argument' do
      it 'should return the default editor' do
        Donald::Editor.new.instance_variable_get('@name').should eql(Donald::Editor::DEFAULT_EDITOR)
      end
    end

    context 'with mate as editor argument' do
      it 'should return mate' do
        Donald::Editor.new('mate').instance_variable_get('@name').should eql('mate')
      end
    end
  end

  context 'with $EDITOR variable as gedit' do
    before :each do
      Donald::Environment.stub!(:editor_variable).and_return('gedit')
    end

    context 'with no argument' do
      it 'should return gedit' do
        Donald::Editor.new.instance_variable_get('@name').should eql('gedit')
      end
    end

    context 'with vim as argument' do
      it 'should return vim' do
        Donald::Editor.new('vim').instance_variable_get('@name').should eql('vim')
      end
    end
  end
end
