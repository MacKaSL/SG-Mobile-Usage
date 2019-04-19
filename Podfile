source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!
platform :ios, '10.0'

def shared_pods
    pod 'Reachability'
    pod 'RealmSwift'
end

target 'SG Mobile Usage' do

  shared_pods
  
  target 'SG Mobile UsageTests' do
    inherit! :search_paths
    shared_pods
  end

  target 'SG Mobile UsageUITests' do
    inherit! :search_paths
    shared_pods
  end
end
