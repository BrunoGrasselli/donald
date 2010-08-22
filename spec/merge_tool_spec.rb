require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::MergeTool do
  before(:each) do
    Kernel.stub!(:system)
    @git = Donald::Git.new
    Donald::Git.stub!(:new).and_return(@git)
    @output = double('output').as_null_object
    Donald::Environment.stub!(:editor_variable).and_return(nil)
  end

  context 'with no unmerged files' do
    before(:each) do
      @git.stub!(:unmerged_files).and_return([])
    end

    let(:merge_tool) { Donald::MergeTool.new(@output) }

    it 'should send an error message' do
      @output.should_receive(:puts).with('No unmerged files found')
      merge_tool.start
    end
  end

  context 'with unmerged files' do
    before(:each) do
      @git.stub!(:unmerged_files).and_return(["app/models/author.rb", "app/models/post.rb", "app/models/comment.rb"])
    end

    describe 'with no arguments' do
      let(:merge_tool) { Donald::MergeTool.new(@output) }

      it 'should call vim' do
        Kernel.should_receive(:system).with('vim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end

    context 'with "mate" as argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['mate']) }

      it 'should call mate' do
        Kernel.should_receive(:system).with('mate app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
  end
end
