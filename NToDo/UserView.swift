//
//  UserView.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/03/07.
//

import SwiftUI

struct UserView: View {
    
    let image : Image
    let userName : String
    
    var body: some View {
        //aligment:leading -> hidariyose
        HStack {
            VStack(alignment: .leading){
                Text("Hello")
                    .foregroundColor(Color.tTitle)
                    .font(.footnote)
                Text("\(userName)")
                    .foregroundColor(Color.tTitle)
                    .font(.title)
            }
            Spacer()
            image
                .resizable().frame(width: 60, height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .padding()
        .background(Color.tBackground)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(image: Image("profile"),
                 userName: "User Name")
    }
}
