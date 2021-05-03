//
//  ContentView.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/02/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing : 0) {
            //ステータス部分の塗りつぶし設定
            Color.tBackground
                .edgesIgnoringSafeArea(.top)
                .frame(height : 0)
            
 //           UserView(image: Image("profile"), userName: "Yuki")
            VStack(spacing : 0) {
                HStack(spacing : 0) {
                    CategoryView(category: .ImpUrg_1st)
                    Spacer()
                    CategoryView(category: .ImpNUrg_2nd)
                }
                Spacer()
                HStack(spacing : 0) {
                    CategoryView(category: .NImpUrg_3rd)
                    Spacer()
                    CategoryView(category: .NImpNUrg_4th)
                }
            }.padding()
            
            TaskToday()
            
        }.background(Color.tBackground)
            .edgesIgnoringSafeArea(.bottom)//セーフエリアの無視
    }
}

struct ContentView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, context)
        }
    }
}
