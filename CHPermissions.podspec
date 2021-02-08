Pod::Spec.new do |s|

  s.name         = 'CHPermissions'
  s.version      = '0.0.1'
  s.license      = 'MIT'
  s.summary      = 'Swift용 권한 상태 확인 및 요청.'
  s.homepage     = 'https://github.com/inchan/CHPermissions'
  s.author       = { 'inchan' => 'kangsazang@gmail.com' }
  
  s.source        = { :git => 'file:///Users/kay/Project/Github/inchan/CHPermissions' }

  s.ios.deployment_target = '10.0'
  s.ios.framework = 'UIKit'

  s.source_files  = 'CHPermissions/**/*.swift'

end
