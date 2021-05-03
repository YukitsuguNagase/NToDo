//
//  CategoryView.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/03/07.
//

import SwiftUI

struct CategoryView: View {
    var category : ToDoEntity.Category
    @State var numberObTasks = 0
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewtask = false
    fileprivate func update() {
        self.numberObTasks = ToDoEntity.count(in: self.viewContext, category: self.category)
    }
    
    var body: some View {
        //leading:左寄せ
        VStack(alignment: .leading) {//要素を縦に配置
            Image(systemName: category.image())
                .font(.largeTitle)
                //カテゴリーがタップされたときに表示するシート情報
                .sheet(isPresented: $showList, onDismiss: {self.update()}) {
                    TodoList(category: self.category)
                        .environment(\.managedObjectContext, self.viewContext)
                }
            
            Text(category.toString())
            Text("・\(numberObTasks)件")
            Button(action: {
                self.addNewtask = true
            }) {
                Image(systemName: "plus")
            }.sheet(isPresented: $addNewtask, onDismiss: {self.update()}) {
                NewTask(category: self.category.rawValue)
                    .environment(\.managedObjectContext, self.viewContext)
            }
            Spacer()
        }.padding()
        .frame(maxWidth:.infinity, minHeight: 150)
            .foregroundColor(.white)
            .background(category.color())
            .cornerRadius(20)
        .onTapGesture {
            self.showList = true
        }
        .onAppear {
            self.update()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        VStack {
        CategoryView(category: .ImpUrg_1st)
        CategoryView(category: .ImpNUrg_2nd)
        CategoryView(category: .NImpUrg_3rd)
        CategoryView(category: .NImpNUrg_4th)
        }.environment(\.managedObjectContext, context)
    }
}
