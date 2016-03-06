Pod::Spec.new do |spec|
  spec.name = "RFA3dTouch"
  spec.version = "1.0.0"
  spec.summary = "3dTouch for all."
  spec.homepage = "https://github.com/rafaj10"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Rafael Assis" => 'rafazassis@gmail.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { :git => 'https://github.com/rafaj10/RFA3dTouch.git', :tag => "#{spec.version}", :submodules => true }
  spec.source_files = "RFA3dTouch/**/*.{h,swift}"
  spec.dependency "Curry", "~> 1.4.0"
end
