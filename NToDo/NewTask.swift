//
//  NewTask.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/18.
//

import SwiftUI

struct NewTask: View {
    @State var task : String = ""
    @State var time : Date? = Date()
    @State var category : Int16 = ToDoEntity.Category.ImpUrg_1st.rawValue
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
    
    @Environment(\.presentationMode) var presentetionMode
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("タスク").foregroundColor(.gray)) {
                    TextField("タスクを入力", text:$task).foregroundColor(.black)
                }
                
                Section(header: Toggle(isOn: Binding(isNotNil: $time, defaultValue: Date())) {
                    Text("時間指定").foregroundColor(.gray) }) {
                    if time != nil {
                        DatePicker(selection: Binding($time, Date()), label: { Text("日時").foregroundColor(.black) })
                    } else {
                        Text("時間未設定").foregroundColor(.gray)
                    }
                   
                }
                
                Picker(selection: $category, label: Text("種類").foregroundColor(.black) ){
                    ForEach(categories, id: \.self) {category in
                        HStack{
                            CategoryImage(category)
                            Text(category.toString()).foregroundColor(.gray)
                        }.tag(category.rawValue)
                    }
                }
                
                Section(header: Text("操作").foregroundColor(.gray)) {
                    Button(action : {
                        self.presentetionMode.wrappedValue.dismiss()
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                        }.foregroundColor(.red)
                    }
                }
                
            }.navigationBarTitle("タスクの追加")
            .navigationBarItems(trailing: Button(action: {
                ToDoEntity.create(in: self.viewContext,
                                  category: ToDoEntity.Category(rawValue: self.category) ?? .ImpUrg_1st,
                                  task: self.task,
                                  time: self.time)
                self.save()
                self.presentetionMode.wrappedValue.dismiss()
            }) {
                Text("保存").foregroundColor(.blue)
            })
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        NewTask()
            .environment(\.managedObjectContext, context)
    }
}
