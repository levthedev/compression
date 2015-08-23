class Compressor
  attr_reader :occurences

  def filepath
    ARGV[0]
  end

  def compress
    Dir.chdir(File.dirname(__FILE__))
    file_array = []
    File.open(filepath, "r") do |f|
      f.each_line { |line| file_array << line }
    end
    string = file_array.join(" ").split(" ")
    @occurences = {}
    new_file = string.each_with_index do |word, i|
      @occurences[word] ? @occurences[word] << i : @occurences[word] = [i]
    end
    out_file = File.new("compressed_#{filepath}", "w")
    out_file.puts(new_file)
    out_file.close
  end

  def uncompress
    arr = []
    hash = @occurences.each_pair do |word, occurences|
      occurences.each { |o| arr[o] ? arr[o] << word : arr[o] = word }
    end
    arr.join(" ")
  end
end

Compressor.new.compress
