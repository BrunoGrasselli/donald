require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Editor do
  describe '#editor_variable' do
    context '#system_variable returns a break line' do
      before :each do
        Donald::Environment.stub!(:system_variable).and_return("\n")
      end

      it 'should return nil' do
        Donald::Environment.editor_variable.should be_nil
      end
    end

    context '#system_variable returns gedit\n' do
      before :each do
        Donald::Environment.stub!(:system_variable).and_return("gedit\n")
      end

      it 'should return gedit' do
        Donald::Environment.editor_variable.should == 'gedit'
      end
    end
  end
end
