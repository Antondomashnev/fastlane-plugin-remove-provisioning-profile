class File
  def self.include_string?(file_path, included_string)
    File.foreach(file_path).any? do |line|
      next unless line.valid_encoding?
      line.include?(included_string)
    end
  end

  def self.include_line?(file_path, included_line)
    stripped_included_line = included_line.strip
    File.foreach(file_path).any? do |line|
      next unless line.valid_encoding?
      line.strip == stripped_included_line
    end
  end

  def self.include_two_lines?(file_path, included_line_1, included_line_2)
    stripped_included_line_1 = included_line_1.strip
    stripped_included_line_2 = included_line_2.strip
    previous_line = ""
    File.foreach(file_path).any? do |line|
      next unless line.valid_encoding?
      if previous_line.strip == stripped_included_line_1 && line.strip == stripped_included_line_2
        true
      else
        previous_line = line
        false
      end
    end
  end
end
