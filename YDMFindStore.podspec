####
##
####
Pod::Spec.new do |spec|

  spec.name         = "YDMFindStore"
  spec.version      = "1.0.1"
  spec.summary      = "YDMFindStore."
  spec.homepage     = "http://yourdev/YDMFindStore"

  spec.license          = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDMFindStore.git", :tag => "#{spec.version}" }
  spec.source_files     = "YDMFindStore/**/*.{h,m,swift,xib,storyboard}"
  spec.swift_version    = "5.0"

  spec.dependency "YDLocationModule"
  spec.dependency "YDExtensions"
  spec.dependency "YDUtilities"
  spec.dependency "YDB2WAssets"
  spec.dependency "YDB2WComponents"
  spec.dependency "Alamofire", "4.9.1"

end
