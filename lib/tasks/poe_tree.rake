require 'yaml'
require_relative '../assets/wordTrie'

namespace :poe_tree do
  desc "TODO"
  task :build_tree => :environment do

    # get a downcase, punctuation-less string from the Poe file
    poe_trie = WordTrie.new


  end

end