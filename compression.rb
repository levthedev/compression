class Compressor
  attr_reader :occurences

  def compress(filepath)
    Dir.chdir(File.dirname(__FILE__))

    file_array = []

    File.open(filepath, "r") do |f|
      f.each_line { |line| file_array << line }
    end

    string = file_array.join(" ").split(" ")

    @occurences = {}
    string.each_with_index do |word, i|
      @occurences[word] ? @occurences[word] << i : @occurences[word] = [i]
    end
  end

  def uncompress
    arr = []
    hash = @occurences.each_pair do |word, occurences|
      occurences.each { |o| arr[o] ? arr[o] << word : arr[o] = word }
    end
    arr.join(" ")
    #hash = hash.to_s.delete(" ")                                       # => "{\"hello\"=>[0,1,2,3,4,5,6,7,8,9,10,11,12]}"
    #File.open("compressed.txt", "w") {|f| f.write(hash)}               # => 41
  end
end
c = Compressor.new
c.compress("test.txt")
c.occurences
c.uncompress

Dir.chdir(File.dirname(__FILE__))
File.size?("compressed.txt")
File.size?("test.txt")
