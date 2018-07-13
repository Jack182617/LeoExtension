Pod::Spec.new do |s|
  s.name         = "Leo-Extension"
  s.version      = "0.0.1"
  s.summary      = "自己常用的一些扩展"
  s.license     = { :type => "MIT" }
  s.homepage = 'https://github.com/yuanjieaili/LeoExtension'
  s.authors = { '袁杰' => '550936272@qq.com' }
  s.source = { :git => 'https://github.com/yuanjieaili/LeoExtension.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source_files = 'Leo-Extension/*.{swift}'
  s.swift_version = '4.1'
end
