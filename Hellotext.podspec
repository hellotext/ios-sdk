#
# Be sure to run `pod lib lint Hellotext.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Hellotext'
  s.version          = '0.1.0'
  s.summary          = 'Hellotext: An SDK for managing text communications in iOS.'

  s.description      = <<-DESC
Hellotext is an SDK designed to simplify the management of text communications within iOS applications.
                       DESC

  s.homepage         = 'https://github.com/hellotext/ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Breno Morais' => 'brenomorais88@gmail.com' }
  s.source           = { :git => 'https://github.com/hellotext/ios-sdk.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.swift_versions = ['5.0']
  s.source_files = 'Hellotext/Classes/**/*'
end
