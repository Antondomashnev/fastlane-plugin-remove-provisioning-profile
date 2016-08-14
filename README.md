# remove_provisioning_profile plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-remove_provisioning_profile)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-remove_provisioning_profile`, add it to your project by running:

```bash
fastlane add_plugin remove_provisioning_profile
```

## About remove_provisioning_profile

The initial use case for the plugin has been discussed in [fastlane issue](https://github.com/fastlane/fastlane/issues/5601).
When `match` or developer adds new provision  profile Xcode still keeps the old one even if the developer doesn't need it anymore. In that case this plugin could help by removing these old or unused provisioning profiles.  

Available options

* `:app_identifier` - the app identifier
* `:type` - provisioning profile type, supported values `["development", "adhoc", "appstore"]`

## Example

Example to run the action
```
remove_provision_profiles(app_identifier: "com.antondomashnev.fastlane-plugin-remove-provisioning-profile", type: "development")
```

Example `fastfile` from our team. The lane removes the old provisioning profiles of all types and then runs `match` to create and load new
```
desc "Recreate the provisioning profiles so you can deploy to your device, release on fabric and push to app store"
  lane :renew_certificates do
    types = ["development", "adhoc", "appstore"]
    app_identifier = "com.antondomashnev.fastlane-plugin-remove-provisioning-profile"
    types.each do |type|
      remove_provision_profiles(app_identifier: app_identifier, type: type)
      match(app_identifier: app_identifier, type: type, force: true)      
    end
end
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use 
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate building and releasing your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
