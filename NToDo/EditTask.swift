//
//  EditTask.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/18.
//

import SwiftUI

struct EditTask: View {
    @ObservedObject var todo : ToDoEntity
    @State var showingsheet = false
    var categories: [ToDoEntity.Category]
        = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NImpNUrg_4th]
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save(){
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror),\(nserror.userInfo)")
        }
    }
    fileprivate func delete(){
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentetionMode
    
    var body: some View {
            Form {
                Section(header: Text("タスク").foregroundColor(.gray)) {
                    TextField("タスクを入力", text:Binding($todo.task,"new task")).foregroundColor(.black)
                }
                
                Section(header: Toggle(isOn: Binding(isNotNil: $todo.time, defaultValue: Date())) {
                    Text("時間指定").foregroundColor(.gray) }) {
                    if todo.time != nil {
                        DatePicker(selection: Binding($todo.time, Date()), label: { Text("日時").foregroundColor(.black) })
                    } else {
                        Text("時間未設定").foregroundColor(.gray)
                    }
                   
                }
                
                Picker(selection: $todo.category, label: Text("種類").foregroundColor(.black) ){
                    ForEach(categories, id: \.self) {category in
                        HStack{
                            CategoryImage(category)
                            Text(category.toString()).foregroundColor(.gray)
                        }.tag(category.rawValue)
                    }
                }
                
                Section(header: Text("操作").foregroundColor(.gray)) {
                    Button(action : {
                        self.showingsheet = true
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("delete")
                        }.foregroundColor(.red)
                    }
                }
                
            }.navigationBarTitle("タスクの編集")
            .navigationBarItems(trailing: Button(action: {
                self.save()
                self.presentetionMode.wrappedValue.dismiss()
            }) {
                Text("閉じる")
            })
            .actionSheet(isPresented: $showingsheet) {
                ActionSheet(title: Text("タスクの削除"), message: Text("このタスクを削除します"), buttons: [.destructive(Text("削除")) {
                    self.delete()
                    self.presentetionMode.wrappedValue.dismiss()
                },
                .cancel(Text("キャンセル"))
                ])
            }
        }
}

struct EditTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        let newTodo = ToDoEntity(context:context)
        return NavigationView {
            EditTask(todo: newTodo)
                .environment(\.managedObjectContext, context)
        }
    }
}
