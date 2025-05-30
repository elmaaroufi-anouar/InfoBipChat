//
//  InfobipApp.swift
//  Infobip
//
//  Created by Anouar El Maaroufi on 26/5/2025.
//
//
//import SwiftUI
//import MobileMessaging
//import InAppChat

//func initializeMobileMessaging() {
//    MobileMessaging
//           .withApplicationCode("fd8d7ac05f1ff7515a22b34996b05bb1-a6091ad2-2b96-47f6-8413-37d541455e28", notificationType: [])?
//           .withInAppChat()
//           .start()
//    
//    // SwiftUI-specific overrides
////    MMChatSettings.sharedInstance.shouldSetNavBarAppearance = false
////    MMChatSettings.sharedInstance.shouldHandleKeyboardAppearance = false
////    MMChatSettings.sharedInstance.shouldUseExternalChatInput = false
//}
//
//@main
//struct InfobipApp: App {
//    
//    init() {
//        initializeMobileMessaging()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

import SwiftUI
import MobileMessaging
import InAppChat
import WebRTCUI
import InfobipRTC

let mmApplicationCode = "YOUR_APPLICATION_CODE"

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MobileMessaging.logger?.logLevel = .All
        MobileMessaging.logger?.logOutput = .Console
        MobileMessaging.withApplicationCode(
            mmApplicationCode, notificationType: [.alert, .sound]
        )?
            .withInAppChat()
            .start()

        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MobileMessaging.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MobileMessaging.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: completionHandler)
    }

}

@main
struct ChatSwiftUIDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
