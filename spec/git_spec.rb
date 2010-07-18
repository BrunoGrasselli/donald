require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Donald::Git do
  before(:each) do
    @output = double('output').as_null_object
    @git = Donald::Git.new
  end

  context 'with no unmerged files' do
    before(:each) do
      @git.stub!(:ls_files).and_return('')
    end
  
    it 'should return an empty collection' do
      @git.unmerged_files.should == []
    end
  end

  context 'with unmerged files' do
    before(:each) do
      files = %{
app/models/author.rb
app/models/post.rb
app/models/comment.rb
      }.strip
      @git.stub!(:ls_files).and_return(files)
    end

    it 'should return an collection with conflicted files' do
      @git.unmerged_files.should == ["app/models/author.rb", "app/models/post.rb", "app/models/comment.rb"]
    end
  end
end
