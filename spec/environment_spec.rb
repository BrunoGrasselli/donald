require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Editor do
  describe '.editor_variable' do
    subject { Donald::Environment.editor_variable }

    context 'when $EDITOR is not set' do
      before :each do
        ENV.stub('[]').with('EDITOR').and_return nil
      end

      it { should be_nil }
    end

    context 'when $EDITOR is set as gedit' do
      before :each do
        ENV.stub('[]').with('EDITOR').and_return 'gedit'
      end

      it { should == 'gedit' }
    end
  end
end
