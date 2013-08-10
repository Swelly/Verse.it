require 'yaml'
require_relative '../assets/wordTrie'

namespace :poe_tree do
  desc "TODO"
  task :build => :environment do

    # get a downcase, punctuation-less string from the Poe file
    poe_all = ''

    File.open( (File.join(Rails.root, "lib", "assets", "poe.txt")) , "r") do |file|
      poe_all = file.read
    end

    poe_all = poe_all.downcase.gsub(/[^a-z\s]/, '').split

    # convert the string to an array of 3-word sequences
    three_word_sequences = []

    poe_all.each_with_index do |word, index|
      str = word
      str.concat(" #{poe_all[index+1]}")
      str.concat(" #{poe_all[index+2]}")
      three_word_sequences << str
      print "."
    end

    puts "I have #{three_word_sequences.count} three-word sequences."
    puts "Here are the first five:"

    puts "#{three_word_sequences[0..4]}"

    # add every 3-word sequence to the trie
    poe_trie = WordTrie.new
    three_word_sequences.each do |seq|
      poe_trie.build(seq)
    end

    # test the trie
    puts "I expect 'upon a midnight' to return true."
    puts "It returns #{poe_trie.find('upon a midnight')}."
    puts "I expect 'alice and octopus' to return nil."
    puts "Does it return nil? #{poe_trie.find('alice and octopus') == nil}."

    # to yaml
    File.open( File.join(Rails.root, "poe_trie.txt"), "w" ) do |file|
      file.write(poe_trie.to_yaml)
    end

  end # end task

end # end namespace