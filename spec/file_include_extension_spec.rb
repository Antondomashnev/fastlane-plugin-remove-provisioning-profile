require 'fastlane/plugin/remove_provisioning_profile/extensions/file_include_extension'

describe File do
  let(:file_path) { "spec/fixtures/text_file_example" }

  describe "include_line" do
    context "when file doesn't contain the given line" do
      it "returns false" do
        expect(File.include_line?(file_path, "that can help")).to be_falsy
      end
    end

    context "when file contains the given line" do
      it "returns true" do
        expect(File.include_line?(file_path, "that can help developers")).to be_truthy
      end
    end
  end

  describe "include_string" do
    context "when file doesn't contain the given substring" do
      it "returns false" do
        expect(File.include_string?(file_path, "help developers to")).to be_falsy
      end
    end

    context "when file contains the given substring" do
      it "returns true" do
        expect(File.include_string?(file_path, "provisioning profile is a")).to be_truthy
      end
    end
  end

  describe "include_two_lines" do
    context "when file doesn't contain both lines" do
      it "returns true" do
        expect(File.include_two_lines?(file_path, "remove provisioning", "profile is a plugin")).to be_falsy
      end
    end

    context "when file doesn't contain one line" do
      it "returns false" do
        expect(File.include_two_lines?(file_path, "that can help developers", "old provisioning")).to be_falsy
      end
    end

    context "when file contains two lines" do
      context "when lines are not following each other" do
        it "returns false" do
          expect(File.include_two_lines?(file_path, "that can help developers", "from their machine")).to be_falsy
        end
      end

      context "when lines are following each other" do
        it "returns true" do
          expect(File.include_two_lines?(file_path, "to remove", "old provisioning profile")).to be_truthy
        end
      end
    end
  end
end
