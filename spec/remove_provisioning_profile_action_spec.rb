require 'fileutils'
require 'fastlane/plugin/remove_provisioning_profile/actions/remove_provisioning_profile_action'

describe Fastlane::Actions::RemoveProvisioningProfileAction do
  describe '#run' do
    before(:each) do
      @provisioning_profiles_folder = "spec/fixtures/temporary_provisioning_profiles"
      FileUtils.mkdir_p(@provisioning_profiles_folder)
      FileUtils.cp_r("spec/fixtures/fake_provisioning_profiles/.", @provisioning_profiles_folder)
    end

    after(:each) do
      FileUtils.rm_rf(@provisioning_profiles_folder)
    end

    context "when app identifier is not found in any provisioning profile" do
      context "when type is development" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Doesn't find any 'development' provisioning profile to remove")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.test.app", type: "development", provisioning_profiles_folder: @provisioning_profiles_folder })
        end
      end

      context "when type is adhoc" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Doesn't find any 'adhoc' provisioning profile to remove")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.test.app", type: "adhoc", provisioning_profiles_folder: @provisioning_profiles_folder })
        end
      end

      context "when type is app store" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Doesn't find any 'appstore' provisioning profile to remove")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.test.app", type: "appstore", provisioning_profiles_folder: @provisioning_profiles_folder })
        end
      end
    end

    context "when app identifier is found in provisioning profile" do
      context "when type is development" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Successfully removed 1 provisioning profiles")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "development", provisioning_profiles_folder: @provisioning_profiles_folder })
        end

        it "removes the file" do
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "development", provisioning_profiles_folder: @provisioning_profiles_folder })
          expect(File.file?("spec/fixtures/temporary_provisioning_profiles/5bc3a976-055e-4970-910a-8e55e6dfcb6e.mobileprovision")).to be_falsy
        end
      end

      context "when type is adhoc" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Successfully removed 1 provisioning profiles")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "adhoc", provisioning_profiles_folder: @provisioning_profiles_folder })
        end

        it "removes the file" do
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "adhoc", provisioning_profiles_folder: @provisioning_profiles_folder })
          expect(File.file?("spec/fixtures/temporary_provisioning_profiles/2fa355cc-903a-48c6-92c0-8014e7f00697.mobileprovision")).to be_falsy
        end
      end

      context "when type is app store" do
        it "prints a message" do
          expect(Fastlane::UI).to receive(:success).with("Successfully removed 1 provisioning profiles")
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "appstore", provisioning_profiles_folder: @provisioning_profiles_folder })
        end

        it "removes the file" do
          Fastlane::Actions::RemoveProvisioningProfileAction.run({ app_identifier: "com.antondomashnev.removing_provisioning_profile", type: "appstore", provisioning_profiles_folder: @provisioning_profiles_folder })
          expect(File.file?("spec/fixtures/temporary_provisioning_profiles/9058b97a-f28c-44cf-8abb-d8a3e2f94de5.mobileprovision")).to be_falsy
        end
      end
    end
  end
end
