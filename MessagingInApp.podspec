require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "MessagingInApp"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/sajidnamseem/react-native-messaging-in-app.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.private_header_files = "ios/**/*.h"
  
  # Swift configuration
  s.swift_version = "5.0"

  # Add dependencies for SMI Client SDKs
  s.dependency "Messaging-InApp-UI"
  s.dependency "Messaging-InApp-Core"
 
  install_modules_dependencies(s)
end
