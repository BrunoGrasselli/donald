require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Editor do
  before :each do
    Kernel.stub!(:system)
    @files = ["app/models/author.rb"]
  end

  describe '#run' do
    context 'with $EDITOR variable not seted up' do
      before :each do
        Donald::Environment.stub!(:editor_variable).and_return(nil)
      end

      context 'with no argument' do
        it 'should run the default editor' do
          Kernel.should_receive(:system).with("#{Donald::Editor::DEFAULT_EDITOR} -p +/HEAD app/models/author.rb")
          Donald::Editor.new.run(@files)
        end
      end

      context 'with mate as editor argument' do
        it 'should run mate' do
          Kernel.should_receive(:system).with('mate app/models/author.rb')
          Donald::Editor.new('mate').run(@files)
        end
      end
    end

    context 'with $EDITOR variable as gedit' do
      before :each do
        Donald::Environment.stub!(:editor_variable).and_return('gedit')
      end

      context 'with no argument' do
        it 'should run gedit' do
          Kernel.should_receive(:system).with('gedit app/models/author.rb')
          Donald::Editor.new.run(@files)
        end
      end

      context 'with vim as argument' do
        it 'should run vim' do
          Kernel.should_receive(:system).with('vim -p +/HEAD app/models/author.rb')
          Donald::Editor.new('vim').run(@files)
        end
      end
    end
  end
end
