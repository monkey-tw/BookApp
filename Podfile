# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
  end
 end
end

target 'BookApp' do

  pod 'Moya', '~> 15.0'
  pod 'Moya/Combine', '~> 15.0'
  pod 'ProgressHUD', '14.1.0'

  # Local pods
  pod 'Networking', :path => './LocalPods/Networking'
  pod 'Platform', :path => './LocalPods/Platform'

  target 'BookAppTests' do
    inherit! :search_paths

  end

  target 'BookAppUITests' do
    # Pods for testing
  end

end
