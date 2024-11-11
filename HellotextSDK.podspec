Pod::Spec.new do |s|
    s.name         = 'HellotextSDK'
    s.version      = '1.0.0'
    s.summary      = 'A short description of HelloTextSDK.'
    s.homepage     = 'https://github.com/hellotext/ios-sdk'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.authors      = { 'Breno Alves de Morais' => 'breno@iamviva.com' }
    s.source       = { :git => 'https://github.com/hellotext/ios-sdk.git', :tag => s.version.to_s }
    s.ios.deployment_target = '11.0'
    s.source_files  = 'Sources/**/*.{h,m,swift}'
    s.public_header_files = 'Sources/**/*.h'
    s.swift_version = '5.0'
end
