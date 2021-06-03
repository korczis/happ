//
//  CorianderSceneDelegate.swift
//  coriander
//
//  Created by Tomas Korcak on 18.05.2021.
//

import AuthenticationServices
import CoreData
import UIKit
import SwiftUI
import KeychainAccess

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        // Store in Keychain
        let service = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
        let keychain = Keychain(service: service!)
        
        let identityId = keychain[KeychainKeys.userIdentityId.rawValue]
        // let identityToken = keychain[KeychainKeys.userIdentityToken.rawValue]
        // let email = keychain[KeychainKeys.userEmail.rawValue]
        // let firstName = keychain[KeychainKeys.userFirstname.rawValue]
        // let lastname = keychain[KeychainKeys.userLastname.rawValue]
        
        appleIDProvider.getCredentialState(forUserID: identityId ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid. Show Home UI Here
                globalState.dispatch(UserLoginAction(
                    identityId: identityId!,
                    
                    callback: { user, error in
                        if let error = error {
                            // FIXME: Try load data from Keychain
                            print("\(String(describing: error))")
                            self.displayAuthView(scene)
                            return
                        }
                        
                        globalState.dispatch(UserCurrentSetAction(
                            user: user
                        ))
                        
                        // FIXME - Add callback to UserCurrentSetAction for this
                        self.displayContentView(scene)
                    }
                ))
                
                
                break
            case .revoked, .notFound:
                self.displayAuthView(scene)
                break;
            default:
                break
            }
        }
    }
    
    func displayAuthView(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        DispatchQueue.main.async {
            let window = UIWindow(windowScene: windowScene)
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.dataStack.context
            let rootView = AuthView()
                .environment(\.window, window)
                .environment(\.managedObjectContext, moc!)
            
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func displayContentView(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        DispatchQueue.main.async {
            let window = UIWindow(windowScene: windowScene)
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.dataStack.context
                                
            let rootView = ContentView()
                .environment(\.window, window)
                .environment(\.managedObjectContext, moc!)
                // .environment(\.geolocationService, geolocationService)
            
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    //    func sceneDidDisconnect(_ scene: UIScene) {
    //        // Called as the scene is being released by the system.
    //        // This occurs shortly after the scene enters the background, or when its session is discarded.
    //        // Release any resources associated with this scene that can be re-created the next time the scene connects.
    //        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    //    }
    //
    //    func sceneDidBecomeActive(_ scene: UIScene) {
    //        // Called when the scene has moved from an inactive state to an active state.
    //        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    //    }
    //
    //    func sceneWillResignActive(_ scene: UIScene) {
    //        // Called when the scene will move from an active state to an inactive state.
    //        // This may occur due to temporary interruptions (ex. an incoming phone call).
    //    }
    //
    //    func sceneWillEnterForeground(_ scene: UIScene) {
    //        // Called as the scene transitions from the background to the foreground.
    //        // Use this method to undo the changes made on entering the background.
    //    }
    //
    //    func sceneDidEnterBackground(_ scene: UIScene) {
    //        // Called as the scene transitions from the foreground to the background.
    //        // Use this method to save data, release shared resources, and store enough scene-specific state information
    //        // to restore the scene back to its current state.
    //    }
}
