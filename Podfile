# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AppTopCar' do
  # Comment the next line if you don't want to use dynamic frameworks
  inhibit_all_warnings!
  use_frameworks!
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings["ONLY_ACTIVE_ARCH"] = "NO"
        end
      end
    end

  pod 'SnapKit', '~> 5.0.0'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'TransitionButton'
  pod 'GoogleMaps', '6.1.1'

  target 'AppTopCarTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AppTopCarUITests' do
    # Pods for testing
  end

end
