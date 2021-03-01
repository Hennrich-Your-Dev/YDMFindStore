####
##
####
Pod::Spec.new do |spec|

  spec.name         = "YDMFindStore"
  spec.version      = "1.0.47"
  spec.summary      = "YDMFindStore."
  spec.homepage     = "http://yourdev/YDMFindStore"

  spec.license          = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.platform         = :ios, "11.0"
  spec.source           = { :git => "https://github.com/Hennrich-Your-Dev/YDMFindStore.git", :tag => "#{spec.version}" }
  spec.source_files     = "YDMFindStore/**/*.{h,m,swift,xib,storyboard}"
  spec.swift_version    = "5.0"

  spec.dependency "YDB2WIntegration", "1.0.15"
  spec.dependency "YDLocationModule", "1.0.5"
  spec.dependency "YDUtilities", "1.0.10"
  spec.dependency "YDExtensions", "1.0.38"
  spec.dependency "YDB2WAssets", "1.0.31"
  spec.dependency "YDB2WComponents", "1.0.71"
  spec.dependency "YDB2WModels", "1.0.13"

  spec.dependency "Alamofire", "4.9.1"
  spec.dependency "curvyRoute"
end
