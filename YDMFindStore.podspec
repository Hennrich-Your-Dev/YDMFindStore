
Pod::Spec.new do |spec|

  spec.name         = "YDMFindStore"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of YDMFindStore."
  spec.homepage     = "http://EXAMPLE/YDMFindStore"

  spec.license          = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDMFindStore.git", :tag => "#{spec.version}" }
  spec.source_files     = "YDMFindStore/**/*.{h,m,swift,xib,storyboard}"
  spec.public_header_files = "YDMFindStore/**/*.h"
  spec.swift_version    = "5.0"

  # spec.dependency "YDLocationModule"
  spec.dependency "YDIntegration"
  spec.dependency "YDExtensions"
  spec.dependency "YDUtilities"
  spec.dependency "YDB2WAssets"
  spec.dependency "YDB2WComponents"
  spec.dependency "Alamofire", "4.9.1"

end
