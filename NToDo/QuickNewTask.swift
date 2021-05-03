//
//  QuickNewTask.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/03/23.
//

import SwiftUI

struct QuickNewTask: View {
    let category: ToDoEntity.Category
    
    @State var newTask: String = ""
    @Environment(\.managedObjectContext) var viewContent
    
    fileprivate func addNewTask(){
        ToDoEntity.create(in: self.viewContent,
                          category: self.category,
                          task: self.newTask)
        
        self.newTask = ""
    }
    
    fileprivate func cancelTask(){
        self.newTask = ""
    }
    
    var body: some View {
        HStack {
            TextField("新しいタスク", text: $newTask, onCommit:  {
                self.addNewTask()
            }).textFieldStyle(RoundedBorderTextFieldStyle()).foregroundColor(.black)
            Button(action: {self.addNewTask()}) {
                Text("追加").foregroundColor(.blue)
            }
            Button(action: {self.cancelTask()}) {
                Text("キャンセル").foregroundColor(.red)
            }
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        QuickNewTask(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
