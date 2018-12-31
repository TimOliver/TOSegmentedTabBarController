Pod::Spec.new do |s|
  s.name     = 'TOSegmentedTabBarController'
  s.version  = '0.0.1'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A splittable tab bar controller controlled by a segmented control view.'
  s.homepage = 'https://github.com/TimOliver/TOSegmentedTabBarController'
  s.author   = 'Tim Oliver'
  s.source   = { :git => 'https://github.com/TimOliver/TOSegmentedTabBarController.git', :tag => s.version }
  s.platform = :ios, '9.0'
  s.source_files = 'TOSegmentedTabBarController/**/*.{h,m}'
  s.requires_arc = true
end