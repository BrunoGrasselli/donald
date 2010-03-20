#!/usr/bin/env ruby
require 'donald/merge_tool'

puts Dir.pwd

merge_tool = Donald::MergeTool.new

merge_tool.call_vim(merge_tool.unmerged_files(merge_tool.git_status))
