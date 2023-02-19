import Flutter
import UIKit
import MirrorWorldSDK

public class MirrorWorldUniversePlugin: NSObject, FlutterPlugin {
    public static let channelId = "mirror_world_flutter"
    public static let eventChannelId = "mirror_world_flutter/event";
    public static var handler: MethodCallHandlerImpl?;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: eventChannelId, binaryMessenger: registrar.messenger())
        let instance = MirrorWorldUniversePlugin()
        handler = MethodCallHandlerImpl(eventChannel: eventChannel, methodChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
       
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        MirrorWorldUniversePlugin.handler?.handle(call: call, result: result)
    }
    
    
    public func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        MWSDK.handleOpen(url: url)
        return true
    }
    
}
