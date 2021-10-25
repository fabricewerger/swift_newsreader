//
//  RegisterView.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject var viewModel = RegisterViewModelImpl(service: RegisterServiceImpl())
    
    
    var body: some View {
        NavigationView{
            VStack{
                switch viewModel.state{
                case .failed:
                    Text("Er is iets misgegaan")
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                case .noAttemptYet:
                    EmptyView()
                        .padding(.bottom, 10)
                case .loading:
                    EmptyView()
                        .padding(.bottom, 10)
                case .successRegister(content: let content):
                    switch content.Success{
                    case true:
                        EmptyView()
                            .padding(.bottom, 10)
                    case false:
                        Text(content.Message)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
                }
                VStack{
                    Text("Gebruikersnaam")
                    TextField("Gebruikersnaam", text: $username)
                        .multilineTextAlignment(.center)
                }.padding(.bottom, 15)
                VStack{
                    Text("Wachtwoord")
                    SecureField("Wachtwoord", text: $password)
                        .multilineTextAlignment(.center)
                }.padding(.bottom, 15)
                Button("Aanmelden"){
                    self.viewModel.register(username: username, password: password)
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
        }.navigationTitle("Aanmelden")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

