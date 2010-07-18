require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::MergeTool do
  before(:each) do
    Kernel.stub!(:system)
    @git = Donald::Git.new
    Donald::Git.stub!(:new).and_return(@git)
    @output = double('output').as_null_object
  end
    
  context 'with no unmerged files' do
    before(:each) do
      @git.stub!(:conflicted_files).and_return([])
    end

    let(:merge_tool) { Donald::MergeTool.new(@output) }
  
    it 'should send an error message' do
      @output.should_receive(:puts).with('No unmerged files found')
      merge_tool.start
    end
  end
  
  context 'with unmerged files' do
    before(:each) do
      @git.stub!(:conflicted_files).and_return(["app/models/author.rb", "app/models/post.rb", "app/models/comment.rb"])
    end
    
    describe 'with no arguments' do
      let(:merge_tool) { Donald::MergeTool.new(@output) }
    
      it 'should call vim' do
        Kernel.should_receive(:system).with('vim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with --vim argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['--vim']) }
    
      it 'should call vim' do
        Donald::Editor.stub!(:new)
        Donald::Editor.should_receive(:new).with('vim')
        merge_tool.start
      end
    end
    
    describe 'with --gvim argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['--gvim']) }
    
      it 'should call gvim' do
        Kernel.should_receive(:system).with('gvim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with -g argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['-g']) }
    
      it 'should call gvim' do
        Kernel.should_receive(:system).with('gvim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with --mvim argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['--mvim']) }
    
      it 'should call mvim' do
        Kernel.should_receive(:system).with('mvim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with -m argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['-m']) }
    
      it 'should call mvim' do
        Kernel.should_receive(:system).with('mvim -p +/HEAD app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with --textmate argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['--textmate']) }
    
      it 'should call textmate' do
        Kernel.should_receive(:system).with('mate app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
    
    describe 'with -t argument' do
      let(:merge_tool) { Donald::MergeTool.new(@output, ['-t']) }
    
      it 'should call textmate' do
        Kernel.should_receive(:system).with('mate app/models/author.rb app/models/post.rb app/models/comment.rb')
        merge_tool.start
      end
    end
  end
end
