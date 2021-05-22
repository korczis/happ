//
//  MainView.swift
//  coriander
//
//  Created by Tomas Korcak on 21.05.2021.
//

import AuthenticationServices
import SwiftUI
import UIKit

// -----

final class SignInWithApple: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

// -----

struct WindowKey: EnvironmentKey {
    struct Value {
        weak var value: UIWindow?
    }
    
    static let defaultValue: Value = .init(value: nil)
}

extension EnvironmentValues {
    var window: UIWindow? {
        get { return self[WindowKey.self].value }
        set { self[WindowKey.self] = .init(value: newValue) }
    }
}

// -----
class SignInWithAppleDelegates: NSObject, ASAuthorizationControllerDelegate {
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!
    
    init(window: UIWindow?, onSignedIn: @escaping (Bool) -> Void) {
        self.window = window
        self.signInSucceeded = onSignedIn
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        // self.present(alert, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
            KeychainItem.currentUserIdentifier = appleIDCredential.user
            KeychainItem.currentUserFullName = appleIDCredential.fullName
            KeychainItem.currentUserEmail = appleIDCredential.email
            
            
            print("User Id - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.description ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")
            
            if let identityTokenData = appleIDCredential.identityToken,
               let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                print("Identity Token \(identityTokenString)")
            }
            
            let user = AuthUser(
                id: appleIDCredential.user,
                name: appleIDCredential.fullName,
                email: appleIDCredential.email
            )
            
            globalState.dispatch(SetAuthUserAction(
                user: user
            ))
            
            let rootView = ContentView()
            
            window.rootViewController = UIHostingController(rootView: rootView)
            window.makeKeyAndVisible()
            
        }
        //        else if let passwordCredential = authorization.credential as? ASPasswordCredential {
        //            // Sign in using an existing iCloud Keychain credential.
        //            let username = passwordCredential.user
        //            let password = passwordCredential.password
        //
        //            // For the purpose of this demo app, show the password credential as an alert.
        //            DispatchQueue.main.async {
        //                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        //                let alertController = UIAlertController(
        //                    title: "Keychain Credential Received",
        //                    message: message,
        //                    preferredStyle: .alert
        //                )
        //                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        //                self.present(alertController, animated: true, completion: nil)
        //            }
        //        }
    }
}

// -----

struct AuthView: View {
    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "BackgroundColor") ?? UIColor())
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // TODO: Compute top insect/padding automatically - LaunchScreen.storyboard
                Text(String("CORIANDER"))
                    // .padding(EdgeInsets(top: 198, leading: 0, bottom: 0, trailing: 0))
                    .font(Font.custom("Papyrus", size: 50))
                                
                SignInWithApple()
                    .frame(width: 280, height: 60)
                    .onTapGesture(perform: showAppleLogin)
                
                Spacer()
                
                Spacer()
            }
        }
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
    }
    
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    private func performExistingAccountSetupFlows() {
        #if !targetEnvironment(simulator)
        // Note that this won't do anything in the simulator.  You need to
        // be on a real device or you'll just get a failure from the call.
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
        #endif
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
            if success {
                print("SignInWithAppleDelegates.performSignIn() - success")
            } else {
                print("SignInWithAppleDelegates.performSignIn() - error")
            }
        }
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        
        controller.delegate = appleSignInDelegates
        
        // controller.presentationContextProvider = appleSignInDelegates
        
        controller.performRequests()
    }
}

struct AuthAppleView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
        // .environment(\.window, self.)
    }
}

class ChildHostingController: UIHostingController<AuthView> {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: AuthView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
