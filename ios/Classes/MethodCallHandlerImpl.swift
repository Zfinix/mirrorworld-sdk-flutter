//
//  MethodCallHandlerImpl.swift
//  mirror_world_flutter
//
//  Created by Ogbonda Chiziaruhoma on 18/02/2023.
//
import Flutter
import Foundation
import MirrorWorldSDK

public class MethodCallHandlerImpl: NSObject, FlutterStreamHandler{
    
    
    var eventChannel: FlutterEventChannel
    var methodChannel: FlutterMethodChannel
    var tag = "MirrorSDKFlutter"
    var events: FlutterEventSink?
    
    init(eventChannel: FlutterEventChannel, methodChannel: FlutterMethodChannel) {
        self.eventChannel = eventChannel
        self.methodChannel = methodChannel
        super.init()
        self.eventChannel.setStreamHandler(self)
    }
    
    
    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        print(call.method);
        print(call.arguments as? Dictionary<String, Any> ?? "");
        
        switch call.method {
        case "initialize":
            self.initialize(call: call, result: result)
            
        case "startLogin":
            self.startLogin(call: call)
            
        case "isLoggedIn":
            self.isLoggedIn(result: result)
            
        case "logOut":
            self.logOut(result: result)
            
        case "openWallet":
            self.openWallet(result: result)
            
        default:
            result(FlutterMethodNotImplemented)
            return
        }
        
    }
    
    
    public func initialize(call: FlutterMethodCall, result: FlutterResult) {
        
        if let args = call.arguments as? Dictionary<String, Any>,
           let apiKey = args["api_key"] as? String ,
           let useDebugMode = args["use_debug_mode"] as? Bool ,
           let mirrorEnv = args["mirror_env"] as? String {
            var env: MWEnvironment {
                switch mirrorEnv {
                case "StagingDevNet":
                    return .StagingDevNet
                case "StagingMainNet":
                    return .StagingMainNet
                case "MainNet":
                    return .MainNet
                default:
                    return .DevNet
                }
            }
            
            let state = MWSDK.initSDK(env: env, apiKey: apiKey)
            MWSDK.setDebug(useDebugMode)
            
            sendEvent(
                event: EventsHelper.mapEvent(
                    name: EventsHelper.initSDK,
                    data: state
                )
            )
        }
    }
    
    public func startLogin(call: FlutterMethodCall) {
        MWSDK.StartLogin(
            onSuccess: { userInfo in
                self.sendEvent(
                    event: EventsHelper.mapEvent(
                        name: EventsHelper.loginEvent,
                        data: userInfo
                    )
                )
            },
            onFail: {
                self.onFetchFailed(code: 0, message: "login failed !")
            }
        )
        
    }
    
    public func isLoggedIn(result: @escaping FlutterResult) {
        MWSDK.CheckAuthenticated { onBool in
            result(onBool)
        }
    }
    
    public func logOut(result: @escaping FlutterResult) {
        MWSDK.Logout {
            result(true)
        } onFail: {
            self.onFetchFailed(code: 0, message: "logout failed !")
        }
    }
    
    public func openWallet(result: @escaping FlutterResult) {
        MWSDK.OpenWallet(
            onLogout: {},
            loginSuccess: { userInfo in
                self.sendEvent(
                    event: EventsHelper.mapEvent(
                        name: EventsHelper.loginEvent,
                        data: userInfo
                    )
                )
            }
        )
    }
    
    
    public func sendEvent(event: [String : Any?]?) {
        if(self.events == nil){
            return;
        }
        self.events!(event)
    }
    
    
    
    private func onFetchFailed(code: Int, message: String?) {
        
        sendEvent(
            event: EventsHelper.mapEvent(
                name: EventsHelper.fetchFailed,
                data:[
                    "code" : code,
                    "message" : message ?? ""
                ]
            )
        )
    }
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        events = nil
        return nil
    }
}


struct EventsHelper {
    static let initSDK: String = "INIT_SDK"
    static let openWalletEvent: String = "OPEN_WALLET_EVENT"
    static let userFetched: String = "USER_FETCHED"
    static let fetchFailed: String = "FETCH_FAILED"
    static let getTokens: String = "GET_TOKENS"
    static let getTransactions: String = "GET_TRANSACTIONS"
    static let getTransaction: String = "GET_TRANSACTION"
    static let loginEvent: String = "LOGIN_EVENT"
    static let getNFTDetails: String = "NFT_DETAILS"
    static let getNFTsOwnedByAddress: String = "NFTs_OWNED_BY_ADDRESS"
    static let getCollectionFilterInfo: String = "GET_COLLECTION_FILTER_INFO"
    static let getCollectionInfo: String = "GET_COLLECTION_INFO"
    static let getNFTInfo: String = "GET_NFT_INFO"
    static let getNFTEvents: String = "GET_NFT_EVENTS"
    static let searchNFTs: String = "SEARCH_NFT"
    static let getNFTRealPrice: String = "GET_NFT_REAL_PRICE"
    
    static func mapEvent(name: String, data: Any?) -> [String : Any?] {
        return [
            "event" : name,
            "data": data,
        ]
    }
}
