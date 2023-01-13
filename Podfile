# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iweather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit', '~> 5.6.0'
  pod 'FLEX', '~> 5.22.1', :configurations => ['Debug']
  pod 'SDWebImage', '~> 5.0'
  pod 'Toast-Swift', '~> 5.0.1'
  
  pod 'QWeather-SDK'
  
  pod 'BMKLocationKit'
  pod 'BaiduMapKit/Search'
end

#post_install do |installer_representation|
#  installer_representation.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      if config.name == 'Debug'
#        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#      end
#    end
#  end
#end
