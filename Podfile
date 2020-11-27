
platform :ios, '11.0'

install! 'cocoapods',
  :preserve_pod_file_structure => true

source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com-yourdev:Hennrich-Your-Dev/YourDev-Pods.git'

def yourdev
  pod 'YDLocationModule'
  pod 'YDUtilities'
  pod 'YDExtensions'
  pod 'YDB2WAssets'
  pod 'YDB2WComponents'
end

target 'YDMFindStore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Integration
  pod 'YDIntegration', :path => '../../YourDevB2W/Modules/Integration/YDIntegration'

  # Pods for YDMHome
  pod 'Alamofire', '4.9.1'

  yourdev

end
