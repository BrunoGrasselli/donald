require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::MergeTool do
  let(:output) { double('output').as_null_object }
  
  before(:each) do
    Kernel.stub!(:system)
  end
    
  context 'with no unmerged files' do
    let(:merge_tool) { Donald::MergeTool.new(output) }
    
    before(:each) do
      git_status_message = status_message_with_no_unmerged_files
    
      merge_tool.stub!(:git_status).and_return(git_status_message)
    end
  
    it 'should send an error message' do
      output.should_receive(:puts).with('No unmerged files found')
    
      merge_tool.start
    end
  end
  
  context 'with unmerged files' do
    before(:each) do
      git_status_message = status_message_with_unmerged_files ['app/models/post.rb', 'app/models/comment.rb'], ['app/models/author.rb']
      
      merge_tool.stub!(:git_status).and_return(git_status_message)
    end
    
    describe 'with no arguments' do
      let(:merge_tool) { Donald::MergeTool.new(output) }
    
      it 'should call vim' do
        Kernel.should_receive(:system).with('vim -p app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with --gvim argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['--gvim']) }
    
      it 'should call gvim' do
        Kernel.should_receive(:system).with('gvim -p app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with -g argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['-g']) }
    
      it 'should call gvim' do
        Kernel.should_receive(:system).with('gvim -p app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with --mvim argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['--mvim']) }
    
      it 'should call mvim' do
        Kernel.should_receive(:system).with('mvim -p app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with -m argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['-m']) }
    
      it 'should call mvim' do
        Kernel.should_receive(:system).with('mvim -p app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with --textmate argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['--textmate']) }
    
      it 'should call textmate' do
        Kernel.should_receive(:system).with('mate app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
    
    describe 'with -t argument' do
      let(:merge_tool) { Donald::MergeTool.new(output, ['-t']) }
    
      it 'should call textmate' do
        Kernel.should_receive(:system).with('mate app/models/post.rb app/models/comment.rb app/models/author.rb')
      
        merge_tool.start
      end
    end
  end
  
end
