//
//  ContentView.swift
//  InternshipProject
//
//  Created by Christopher Koski on 10/5/22.
//

import SwiftUI

struct ContentView: View {
  
  @State private var username: String = ""
  @State private var password1: String = ""
  @State private var password2: String = ""
  
  @State private var validUsername = false
  @State private var validPassword = false
  
  var body: some View {
    VStack {
      Text("Welcome!")
        .font(.title)
        .fontWeight(.bold)
      VStack {
        TextField("Username", text: $username)
        SecureField("Password", text: $password1)
        
        SecureField("Confirm Password", text: $password2)
      }
      
      Button {
        print("Button tapped")
        if validate(password: password1) == true {
          if password1 == password2 {
            print("Valid")
            validPassword = true
            validEmail()
          }
        }
      } label: {
        Text("Create User")
      }
      .padding()
      
      //Hide error when view loads initially
      if validPassword != true {
        Text("Password must contain 1 Uppercase, 1 Special character, and 2 numbers.")
          .foregroundColor(.red)
          .multilineTextAlignment(.center)
      } else if validUsername == true && validPassword == true {
        Text("Account created!")
          .font(.title2)
          .foregroundColor(Color.teal)
      } else {
        Text("Enter a valid")
      }
      
    }
    .padding()
  }
  
  func validEmail() {
    if username.contains("@") {
      validUsername = true
    } else {
      validUsername = false
    }
  }
  
  //currently only checking for one number
  func validate(password: String) -> Bool {
    let capitalLetterRegEx  = ".*[A-Z]+.*"
    let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
    guard texttest.evaluate(with: password) else { return false }
    
    let numberRegEx  = ".*[0-9]+.*"
    let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    guard texttest1.evaluate(with: password) else { return false }
    
    let specialCharacterRegEx  = ".*[!&^%$#@()/_*+-]+.*"
    let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
    guard texttest2.evaluate(with: password) else { return false }
    
    guard password.count >= 6 else { return false }
    return true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
