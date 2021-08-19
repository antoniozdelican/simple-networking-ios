#
# Be sure to run `pod lib lint SimpleNetworking.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'SimpleNetworking'
  s.version          = '1.0.0'
  s.summary          = 'SimpleNetworking iOS SDK'

  s.description      = <<-DESC
  This library contains networking wrapper classes for URLSession. Install this Cocoapod to integrate the SimpleNetworking in your iOS app.
                       DESC

  s.homepage         = 'https://github.com/antoniozdelican/SimpleNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'antoniozdelican' => 'antonio.zdelican@gmail.com' }
  s.source           = { :git => 'https://github.com/antoniozdelican/SimpleNetworking.git', :tag => s.version.to_s }

  s.swift_version = "5.3"
  s.ios.deployment_target = '12.0'

  s.source_files = 'SimpleNetworking/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SimpleNetworking' => ['SimpleNetworking/Assets/*.png']
  # }
#  s.test_spec 'SimpleNetworkingTests' do |test_spec|
#    test_spec.source_files = 'Tests/SimpleNetworkingTests/**/*.{h,m,swift}'
#  end
end
