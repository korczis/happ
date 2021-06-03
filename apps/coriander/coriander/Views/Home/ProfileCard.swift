//
//  ProfileCard.swift
//  coriander
//
//  Created by Tomas Korcak on 31.05.2021.
//

import SwiftUI
import Kingfisher

struct ProfileCard : View {
    var user: User
    
    var avatar: KFImage {
        let hash: String = (user.email?.MD5)!
        let url = "https://www.gravatar.com/avatar/\(hash)?s=200"
        
        return KFImage(
            source: .network(URL(string: url)!)
        )
    }
    
    var body: some View {
        ZStack {
            // Color.gray.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    
                    Text(String("\(user.firstname!) \(user.lastname!)"))
                        .font(.title)
                    
                    Spacer()
                }
                .padding(.bottom)
                
                avatar
                    // .scaleFactor(UIScreen.main.scale)
                    .renderingMode(.original)
                // .resizable()
                
                HStack() {
                    Spacer()
                    
                    Text("\(user.email!)")
                        .font(.subheadline)
                    
                    Spacer()
                }
                .padding(.bottom)
            }
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var user: User {
        let user = User()
        
//        user.firstname = "Joe"
//        user.lastname  = "Doe"
//        user.email = "joe.doe@example.com"
//        user.firstLoginAt = Date()
//        user.lastLoginAt = Date()
        
        return user
    }
    
    static var previews: some View {
        ProfileCard(user: user)
    }
}
