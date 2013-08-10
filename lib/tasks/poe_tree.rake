require 'yaml'
require_relative '../assets/wordTrie'

namespace :poe_tree do
  desc "TODO"
  task :build_tree => :environment do

    # get a downcase, punctuation-less string from the Poe file
    poe_all = ''
    File.open("../assets/poe.txt", "r") do |file|
      poe_all = f.read
    end

    poe_all = poe_all.downcase.gsub(/[^a-z\s]/, '').split

    # add every 3-word sequence to the trie
    poe_trie = WordTrie.new

    # to yaml
  end

end