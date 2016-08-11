describe Fastlane::Actions::RemoveProvisioningProfileAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The remove_provisioning_profile plugin is working!")

      Fastlane::Actions::RemoveProvisioningProfileAction.run(nil)
    end
  end
end
