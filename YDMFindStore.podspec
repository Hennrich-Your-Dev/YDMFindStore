####
##
####
Pod::Spec.new do |spec|

  spec.name         = "YDMFindStore"
  spec.version      = "1.0.23"
  spec.summary      = "YDMFindStore."
  spec.homepage     = "http://yourdev/YDMFindStore"

  spec.license          = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDMFindStore.git", :tag => "#{spec.version}" }
  spec.source_files     = "YDMFindStore/**/*.{h,m,swift,xib,storyboard}"
  spec.swift_version    = "5.0"

  spec.dependency "YDB2WIntegration"
  spec.dependency "YDLocationModule"
  spec.dependency "YDUtilities"
  spec.dependency "YDExtensions"
  spec.dependency "YDB2WAssets"
  spec.dependency "YDB2WComponents"
  spec.dependency "YDB2WModels"

  spec.dependency "Alamofire", "4.9.1"
end
