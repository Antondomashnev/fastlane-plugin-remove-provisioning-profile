module Fastlane
  module Helper
    class RemoveProvisioningProfileHelper
      # class methods that you define here become available in your action
      # as `Helper::RemoveProvisioningProfileHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the remove_provisioning_profile plugin helper!")
      end
    end
  end
end
