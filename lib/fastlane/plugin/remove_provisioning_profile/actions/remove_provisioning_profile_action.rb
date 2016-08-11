module Fastlane
  module Actions
    class RemoveProvisioningProfileAction < Action
      def self.run(params)
        UI.message("The remove_provisioning_profile plugin is working!")
      end

      def self.description
        "Remove provisioning profile from your local machine"
      end

      def self.authors
        ["antondomashnev"]
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "REMOVE_PROVISIONING_PROFILE_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
