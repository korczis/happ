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
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            var identityToken = ""
            if let identityTokenData = appleIDCredential.identityToken {
                identityToken = String(data: identityTokenData, encoding: .utf8)!
            }
            
            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
            KeychainItem.currentUserIdentifier = appleIDCredential.user
            KeychainItem.currentUserFullName = appleIDCredential.fullName
            KeychainItem.currentUserEmail = appleIDCredential.email
            KeychainItem.currentUserIdentityToken = identityToken
                        
            print("User Id - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.description ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")
                        
            let now = Date()
            globalState.dispatch(UserCreateAction(
                id: UUID(),
                firstname: appleIDCredential.fullName?.givenName,
                lastname: appleIDCredential.fullName?.familyName,
                email: appleIDCredential.email,
                identityToken: identityToken,
                identityId: appleIDCredential.user,
                firstLoginAt: now,
                lastLoginAt: now,
                callback: { user, error in
                    if let error = error {
                        print("\(String(describing: error))")
                    }
                    
                    globalState.dispatch(UserCurrentSetAction(
                        user: user
                    ))
                }
            ))            
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            let rootView = ContentView()
                .environment(\.managedObjectContext, moc!)
            
            window.rootViewController = UIHostingController(rootView: rootView)
            window.makeKeyAndVisible()
            
        }
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
