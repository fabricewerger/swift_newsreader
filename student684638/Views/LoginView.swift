//
//  LoginView.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    private let localStorage: LocalStorage = .init()
    
    @StateObject var viewModel = LoginViewModelImpl(service: LoginServiceImpl())
    
    var body: some View {
        let authToken = localStorage.fetchToken()
        switch authToken{
        case "":
            NavigationView{
                VStack{
                    switch viewModel.state{
                    case .failed:
                        Text("Gegevens onjuist").foregroundColor(.red).padding(.bottom, 10)
                    case .noAttemptYet:
                        EmptyView().padding(.bottom, 10)
                    case .loading:
                        EmptyView().padding(.bottom, 10)
                    case .successLogin(content: _):
                        EmptyView().padding(.bottom, 10)
                    }
                    VStack {
                        Text("Gebruikersnaam")
                        TextField("Gebruikersnaam", text: $username)
                            .multilineTextAlignment(.center)
                    }.padding(.bottom, 15)
                    VStack{
                        Text("Wachtwoord")
                        SecureField("Wachtwoord", text: $password)
                            .multilineTextAlignment(.center)
                    }.padding(.bottom, 15)
                    Button("Login"){
                        self.viewModel.login(username: username, password: password)
                        username = ""
                        password = ""
                    }.padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .heavy))
                        .cornerRadius(5)
                    Spacer()
                }.padding()
            }.navigationTitle("Login")
            NavigationLink(destination: RegisterView()){
                Text("Meld je hier aan!")
                    .padding(.bottom, 50)
            }
        default:
            NavigationView{
                VStack{
                    Button("Logout"){
                        viewModel.logout()
                    }.padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .heavy))
                        .cornerRadius(5)
                }
                
            }.navigationTitle("Profiel")
                .navigationBarItems(trailing:
                NavigationLink(destination: LikedArticleView()){
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
