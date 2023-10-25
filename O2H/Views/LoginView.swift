//
//  ContentView.swift
//  O2H
//
//  Created by Vikash on 24/10/23.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    @State var showImageScreen: Bool = false
    var body: some View {
        NavigationView {
            HStack {
                Text("Login ")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .bold))
                
                Button(action: {
                    showImageScreen = true
                }, label: {
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(width: 120,height: 40)
                        .cornerRadius(40)
                        .overlay(content: {
                            HStack{
                                Text("Google")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .bold))
                                Image(systemName: "person.badge.key")
                                    .foregroundColor(.black)
                            }
                            
                        })
                })
                NavigationLink(
                    destination: ImageView()
                        .navigationBarBackButtonHidden(),
                    isActive: $showImageScreen,
                    label: { EmptyView() }
                )
            }
            .padding()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
