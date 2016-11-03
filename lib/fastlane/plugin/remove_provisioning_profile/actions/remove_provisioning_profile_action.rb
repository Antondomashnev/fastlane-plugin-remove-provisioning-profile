module Fastlane
  module Actions
    class RemoveProvisioningProfileAction < Action
      require 'fastlane/plugin/remove_provisioning_profile/extensions/file_include_extension'

      def self.run(params)
        app_identifier = params[:app_identifier]
        type = params[:type]
        provisioning_profiles_folder = params[:provisioning_profiles_folder] ? params[:provisioning_profiles_folder] : "#{Dir.home}/Library/MobileDevice/Provisioning Profiles"
        unless Dir.exist?(provisioning_profiles_folder)
          UI.important("There is no directory at the given path '#{provisioning_profiles_folder}' skipping the action")
          return
        end

        UI.message("Looking for '#{type}' provisioning profile of '#{app_identifier}' in '#{provisioning_profiles_folder}'") if $verbose

        provisioning_profiles = []
        Dir.foreach(provisioning_profiles_folder) do |file|
          next unless file.end_with?(".mobileprovision")
          file_path = "#{provisioning_profiles_folder}/#{file}"
          if self.mobileprovision_of_app_identifier?(file_path, app_identifier) && self.mobileprovision_of_type?(file_path, type)
            provisioning_profiles << file_path
            UI.message("Found matched provisioning profile at '#{file_path}'") if $verbose
          end
        end

        FileUtils.rm(provisioning_profiles)
        if provisioning_profiles.count > 0
          UI.success("Successfully removed #{provisioning_profiles.count} provisioning profiles")
        else
          UI.success("Doesn't find any '#{type}' provisioning profile to remove")
        end
      end

      def self.mobileprovision_of_app_identifier?(mobileprovision, app_identifier)
        return File.include_string?(mobileprovision, "#{app_identifier}</string>")
      end

      def self.mobileprovision_of_type?(mobileprovision, type)
        if type == "development"
          return File.include_two_lines?(mobileprovision, "<key>get-task-allow</key>", "<true/>")
        elsif type == "adhoc"
          return File.include_line?(mobileprovision, "<key>ProvisionedDevices</key>") && File.include_two_lines?(mobileprovision, "<key>get-task-allow</key>", "<false/>")
        elsif type == "appstore"
          return !File.include_line?(mobileprovision, "<key>ProvisionedDevices</key>")
        end
        raise "Unknown mobileprovision type '#{type}'. Possible values: 'development', 'adhoc', 'appstore'".red
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Remove the provisioning profile for the given app_identifier and type from local machine"
      end

      def self.authors
        ["antondomashnev"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_identifier,
                                       description: "The app identifier",
                                       optional: false,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("No app identifier") if value.to_s.length.zero?
                                       end),
          FastlaneCore::ConfigItem.new(key: :type,
                                       description: "Provisioning profile type",
                                       optional: false,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid provisioning profile type '#{value}'. Supported types are: 'development', 'adhoc', 'appstore'") unless ["development", "adhoc", "appstore"].include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :provisioning_profiles_folder,
                                       description: "Folder with provisioning profiles",
                                       optional: true,
                                       type: String)
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
