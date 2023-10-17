# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'template_project_01' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'ObjectMapper'
  pod 'Alamofire', '~> 4.8.2'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SwiftyJSON'
  pod 'ReachabilitySwift'
  pod 'CocoaLumberjack/Swift'
  pod 'Moya'
  pod 'Toast-Swift'
  pod 'NVActivityIndicatorView'
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'
  # Pods for template_project_01

  target 'template_project_01Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'template_project_01UITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
      target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
  end
end
