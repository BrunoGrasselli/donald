require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Git do
  before(:each) do
    @output = double('output').as_null_object
    @git = Donald::Git.new
  end

  context 'with no unmerged files' do
    before(:each) do
      @git.stub!(:status).and_return(status_message_with_no_unmerged_files)
    end
  
    it 'should return an empty collection' do
      @git.conflicted_files.should == []
    end
  end

  context 'with unmerged files' do
    before(:each) do
      status_message = status_message_with_unmerged_files(
        'unmerged' => 'app/models/post.rb',
        'both modified' => 'app/models/comment.rb',
        'both added' => 'app/models/author.rb')
      @git.stub!(:status).and_return(status_message)
    end

    it 'should return an collection with conflicted files' do
      @git.conflicted_files.should == ["app/models/author.rb", "app/models/post.rb", "app/models/comment.rb"]
    end
  end
end
