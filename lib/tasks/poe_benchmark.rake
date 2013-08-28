require 'benchmark'
require Rails.root.join('lib', 'assets', 'wordTrie.rb')

namespace :poe_benchmark do
  desc "TODO"
  task :benchmark => :environment do

    # Create an input that won't find a match
    @poem_text = "Alice, the octopus, what makes computers stay? Servers in hyperspace."

    @words = @poem_text.downcase.gsub(/[^a-z\s]/, '').split

    yaml_string = File.read(File.join(Rails.root, 'poe_trie.txt'))
    @poe_trie = YAML::load(yaml_string)

    @three_word_sequences = []
    File.open(File.join(Rails.root, 'poe_naive_array.txt')).each do |line|
      @three_word_sequences << line
    end

    # Method for testing the trie implementation

    def trie_test
      @words.each_with_index do |word, i|
        # binding.pry
        seq = "#{word} #{@words[i+1]} #{@words[i+2]}"
        if
          @poe_trie.find(seq)
          return true
        end
      end
      return false
    end

    # Method for testing the naive implementation

    def array_test
      @words.each_with_index do |word, i|
        # binding.pry
        seq = "#{word} #{@words[i+1]} #{@words[i+2]}"
        if @three_word_sequences.include? seq
          return true
        end
      end
      return false
    end

    Benchmark.bmbm do |x|
      x.report("array:") { array_test }
      x.report("trie:") { trie_test }
    end

  end
end