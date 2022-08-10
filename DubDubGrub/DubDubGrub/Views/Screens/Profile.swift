//
//  Profile.swift
//  DubDubGrub
//
//  Created by Christopher Koski on 8/9/22.
//

import SwiftUI

struct Profile: View {
  
  @State private var bio = ""
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var companyName = ""
  
  var body: some View {
    VStack {
      ZStack {
        NameBackgroundView()
        
        HStack(spacing: 16) {
          ZStack {
            AvatarView(size: 84)
            EditImage()
          }
          .padding(.leading)
          VStack(spacing: 1) {
            TextField("First Name", text: $firstName)
              .profileNameStyle()
            TextField("Last Name", text: $lastName)
              .profileNameStyle()
            TextField("Company Name", text: $companyName)
          }
          .padding(.trailing, 16)
        }
        .padding()
      }
      VStack(spacing: 8) {
        HStack {
          CharactersRemainView(currentCount: bio.count)
          Spacer()
          Button {
            
          } label: {
            Label("Check out", systemImage: "mappin.and.ellipse")
          }
        }
        TextEditor(text: $bio)
          .frame(height: 100)
          .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(Color.secondary, lineWidth: 1)
          )
      }
      .padding(.horizontal, 20)
      
      Spacer()
      
      Button {
        
      } label : {
        DDGButton(title: "Create Profile")
      }
    }
    .navigationTitle("Profile")
  }
}

struct Profile_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Profile()
    }
  }
}

struct NameBackgroundView: View {
  var body: some View {
    Color(.secondarySystemBackground)
      .frame(height: 130)
      .cornerRadius(12)
      .padding(.horizontal)
  }
}

struct EditImage: View {
  var body: some View {
    Image(systemName: "square.and.pencil")
      .resizable()
      .scaledToFit()
      .frame(width: 14, height: 14)
      .foregroundColor(.white)
      .offset(y: 30)
  }
}

struct CharactersRemainView: View {
  var currentCount: Int
  
  var body: some View {
    Text("Bio: ")
      .font(.callout)
      .foregroundColor(.secondary)
    +
    Text("\(100 - currentCount)")
      .font(.callout)
      .bold()
      .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
      .foregroundColor(.secondary)
    +
    Text(" characters remain")
      .font(.callout)
      .foregroundColor(.secondary)
  }
}
