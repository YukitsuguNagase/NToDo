//
//  TodoList.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/06.
//

import SwiftUI
import CoreData

struct TodoList: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoEntity.time,
                                           ascending: true)],
        animation: .default)
    var todoList: FetchedResults<ToDoEntity>
    
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var keyboard = KeyboardObserver()
    
    fileprivate func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let entity = todoList[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save()
        } catch {
            print("Delete Error. \(offsets)")
        }
    }
    
    let category : ToDoEntity.Category
    
    var body: some View {
        NavigationView {
            
            VStack{
                List{
                    ForEach(todoList) { todo in
                        //この条件は↓
                        if todo.category == self.category.rawValue{
                            NavigationLink(destination: EditTask(todo: todo)) {
                                TodoDetailRow(todo : todo, hideIcon: true)
                            }
                            
                        }
                    }.onDelete(perform: deleteTodo)
                }
                QuickNewTask(category: category)
                    .padding()
            }.navigationBarTitle(category.toString())
            .navigationBarItems(trailing: EditButton())
        }.onAppear {
            self.keyboard.startObserve()
            UIApplication.shared.closeKeyboard()
        }.onDisappear{
            self.keyboard.stopObserve()
            UIApplication.shared.closeKeyboard()
        }.padding(.bottom, keyboard.keyboardHeight)
        
    }
}

struct TodoList_Previews: PreviewProvider {
    static let container = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
    static let context = container.viewContext
    static var previews: some View {
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "ToDoEntity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)
        
        // データを追加
        ToDoEntity.create(in: context,
                          category: .ImpUrg_1st, task: "炎上プロジェクト")
        ToDoEntity.create(in: context,
                          category: .ImpNUrg_2nd, task: "自己啓発")
        ToDoEntity.create(in: context,
                          category: .NImpUrg_3rd, task: "意味のない会議")
        ToDoEntity.create(in: context,
                          category: .NImpNUrg_4th, task: "暇つぶし")
        //↑このカテゴリーのやつだけを表示するようにしてる
        return TodoList(category: .ImpNUrg_2nd)
            .environment(\.managedObjectContext, context)
    }
}
