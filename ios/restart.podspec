#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint restart.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'restart'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin to restart the application.'
  s.description      = <<-DESC
A Flutter plugin to restart the application.
                       DESC
  s.homepage         = 'https://github.com/farmako/restart'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Farmako Healthcare' => 'tech@farmako.in' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
