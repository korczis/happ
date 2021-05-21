//
//  AuthService.swift
//  coriander
//
//  Created by Tomas Korcak on 20.05.2021.
//

import Foundation
import AuthenticationServices
import Security

class AuthService:
    ASAuthorizationController,
    ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding {
    // Prepare requests for both Apple ID and password providers.
    private static  let requests = [
        ASAuthorizationAppleIDProvider().createRequest(),
        ASAuthorizationPasswordProvider().createRequest()
    ]
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first!
    }
    
    // A singleton for our entire app to use
    public static var shared = AuthService()
    
    init() {
        super.init(authorizationRequests: AuthService.requests)
    }
    
    func performExistingAccountSetupFlows() {
        // Create an authorization controller with the given requests.
        
        let passwordProviderRequest = ASAuthorizationPasswordProvider()
            .createRequest()
        
        let appleIDProviderRequest = ASAuthorizationAppleIDProvider()
            .createRequest()
        appleIDProviderRequest.requestedScopes = [.fullName, .email]
        
        
        let requests = [
            passwordProviderRequest,
            appleIDProviderRequest,
            
        ]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    internal func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // TODO: Implement
        // let userName = NSUserName()
        // let fullUserName = NSFullUserName()
        // let device = UIDevice.current
        
        print("Authorization sucess: \(authorization)")
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("User ID: \(userIdentifier)")
            print("Full Name: \(String(describing: fullName))")
            print("Email ID: \(String(describing: email))")
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            // self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            // self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        }
        
        return
    }
    
    
    internal func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: Implement
        print("Authorization error: \(error)")
    }
}
