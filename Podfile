platform :ios, '10.0'
use_frameworks!

workspace 'SteamAnalytics.xcworkspace'

def corestore_pod
	pod 'CoreStore', '7.0.1'
end

def snapkit_pod
	pod 'SnapKit', '5.0.1'
end

def kingfisher_pod
	pod 'Kingfisher', '5.10.1'
end

target 'SteamAnalyticsApp' do
  project 'App/App.xcodeproj'
end

target 'Storages' do
  project 'Storages/Storages.xcodeproj'

  corestore_pod
end
