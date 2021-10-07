//
//  UserView.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 5/31/21.
//

import SwiftUI

struct UserView: View {
    var user : User
    
    init(users: User) {
        self.user = users
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(user.profilePic)
                Text("\(user.name)")
            }
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(users: User(name: String(), email: String(), password: String(), id: Int(), profilePic: String()))
    }
}
