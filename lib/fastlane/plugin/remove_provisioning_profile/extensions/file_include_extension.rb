class File
  def self.include_string?(file_path, included_string)
    File.foreach(file_path).any? do |line|
      line.include?(included_string)
    end
  end

  def self.include_line?(file_path, included_line)
    File.foreach(file_path).any? do |line|
      line == included_line
    end
  end

  def self.include_two_lines?(file_path, included_line_1, included_line_2)
    previous_line = nil
    File.foreach(file_path).any? do |line|
      if previous_line == included_line_1 && line == included_line_2
        true
      else
        previous_line = line
        false
      end
    end
  end
end
