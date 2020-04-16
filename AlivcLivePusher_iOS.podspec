
Pod::Spec.new do |spec|

  spec.name         = "AlivcLivePusher_iOS"
  spec.summary      = "阿里推流SDK"
  spec.description  = <<-DESC
                      - 推流SDK中包含背景音乐相关功能。如果您需要使用该功能，要使用依赖播放器SDK的版本；如果您不需要背景音乐功能，则使用不依赖播放器SDK的版本即可。
                      - AlivcLibFaceResource.bundle是人脸识别资源文件，如果您需要使用美颜的人脸识别高级功能，则必须导入开发工程；反之则不需要。
                      DESC
  spec.homepage     = "https://help.aliyun.com/document_detail/61989.html"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "aliyunvideo" => "videosdk@service.aliyun.com" }
  spec.version      = "3.5.0"
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  spec.source       = { :git => "https://github.com/wbcyclist/AlivcLivePusherSDK-iOS.git", :tag => "#{spec.version}" }
  spec.requires_arc = true
  spec.xcconfig = { "ENABLE_BITCODE" => "NO" }

  spec.default_subspec = 'Pusher'
  # spec.frameworks = "Accelerate", "AssetsLibrary", "AudioToolbox", "AVFoundation", "CoreMedia", "Foundation", "UIKit", "VideoToolbox"
  spec.subspec 'Pusher' do |pusher|
    pusher.vendored_frameworks = "SDK/AlivcLivePusher/AlivcLivePusher.framework", "SDK/AlivcLivePusher/AlivcLibRtmp.framework", "SDK/AlivcLivePusher/AlivcLibBeauty.framework", "SDK/AlivcLivePusher/AlivcLibFace.framework"
    pusher.resource = "SDK/Resource/AlivcLibFaceResource.bundle"
  end

  spec.subspec 'WithPlayer' do |withPlayer|
    withPlayer.vendored_frameworks = "SDK/AlivcLivePusherWithPlayer/AlivcLivePusher.framework", "SDK/AlivcLivePusherWithPlayer/AlivcLibRtmp.framework", "SDK/AlivcLivePusherWithPlayer/AlivcLibBeauty.framework", "SDK/AlivcLivePusherWithPlayer/AlivcLibFace.framework", "SDK/AlivcLivePusherWithPlayer/AliyunPlayerSDK.framework", "SDK/AlivcLivePusherWithPlayer/AliThirdparty.framework"
    withPlayer.resource = "SDK/Resource/AlivcLibFaceResource.bundle", "SDK/Resource/AliyunLanguageSource.bundle"
  end

end