//
//  ContentView.swift
//  joes
//
//  Created by Tomas Korcak on 11.05.2021.
//

// MARK: Imports
import AuthenticationServices
import Foundation
import Mapbox
import ReSwift
import SwiftUI

// -----
// MARK: Global Store Instance
// -----
let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

var globalState = ObservableState(store: mainStore)

// -----

struct QuickSignInWithApple: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    return ASAuthorizationAppleIDButton(
        type: .signIn,
        style: colorScheme == .dark ? .white : .black
    )
  }

  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}

class SignInWithAppleViewModel: NSObject, ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController,
                               didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
      case let appleIdCredential as ASAuthorizationAppleIDCredential:
        print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
        print(appleIdCredential.email ?? "Email not available.")
        print(appleIdCredential.fullName ?? "fullname not available")
        print(appleIdCredential.fullName?.givenName ?? "givenName not available")
        print(appleIdCredential.fullName?.familyName ?? "Familyname not available")
        print(appleIdCredential.user)  // This is a user identifier
        print(appleIdCredential.identityToken?.base64EncodedString() ?? "Identity token not available") //JWT Token
        print(appleIdCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
        break
        
      case let passwordCredential as ASPasswordCredential:
        print("\n ** ASPasswordCredential ** \n")
        print(passwordCredential.user)  // This is a user identifier
        print(passwordCredential.password) //The password
        break
        
      default:
        break
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
    print(error)
  }
}


// -----

struct ContentView: View {
    @ObservedObject private var state = globalState
    
    private var signInWithAppleViewModel: SignInWithAppleViewModel = SignInWithAppleViewModel()
    
    var geolocationService: GeolocationService = GeolocationService(state: globalState)
    
    
    var contentView: some View {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier ?? "")
        
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier ?? "") { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // The Apple ID credential is valid. Show Home UI Here
//
//
//                let identifier = KeychainItem.currentUserIdentifier
//                let firstName = KeychainItem.currentUserFirstName
//                let lastName = KeychainItem.currentUserLastName
//                let email = KeychainItem.currentUserEmail
//
//
//                break
//            case .revoked:
//                // The Apple ID credential is revoked. Show SignIn UI Here.
//
//                // AuthService.shared.performExistingAccountSetupFlows()
//                break
//            case .notFound:
//                // No credential was found. Show SignIn UI Here.
//                break
//            default:
//                break
//            }
//        }
        
        QuickSignInWithApple()
                .frame(width: 280, height: 60, alignment: .center)
                .onTapGesture(perform: showAppleLoginView)
    }
    
    var body: some View {
        // HomeView(state: state)
        
                
        return contentView
    }
    
    private func showAppleLoginView() {
        // signInWithAppleViewModel = SignInWithAppleViewModel()
        
        // 1. Instantiate the AuthorizationAppleIDProvider
        let provider = ASAuthorizationAppleIDProvider()
        // 2. Create a request with the help of provider - ASAuthorizationAppleIDRequest
        let request = provider.createRequest()
        // 3. Scope to contact information to be requested from the user during authentication.
        request.requestedScopes = [.fullName, .email]
        // 4. A controller that manages authorization requests created by a provider.
        let controller = ASAuthorizationController(authorizationRequests: [request])
        // 6. Initiate the authorization flows.
        controller.performRequests()
      }
}

struct ContentView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        DataView(state: state)
    }
}
