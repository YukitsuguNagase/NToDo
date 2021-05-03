//
//  TodoDetailRow.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/12.
//

import SwiftUI

struct TodoDetailRow: View {
    //coreDataのデータを受け取り利用するオブジェクトにつけるアノテーション
    @ObservedObject var todo : ToDoEntity
    var hideIcon = false
    var body: some View {
        HStack {
            if !hideIcon{
                CategoryImage(ToDoEntity.Category(rawValue: todo.category))
            }
            CheckBox(checked: Binding(
                get:{
                    self.todo.state == ToDoEntity.State.done.rawValue
                },
                set:{
                    //todo stateの値を0か1で判定する ? 0の時:1の時
                    self.todo.state = $0 ? ToDoEntity.State.done.rawValue :
                        ToDoEntity.State.todo.rawValue
                })) {
                //タスクの状態がdone(完了)なら取り消し線
                if self.todo.state == ToDoEntity.State.done.rawValue {
                    Text(self.todo.task ?? "no title").strikethrough()
                }else{
                    Text(self.todo.task ?? "no title")
                }
                
            }.foregroundColor(self.todo.state == ToDoEntity.State.done.rawValue ? .secondary : .primary)//三項演算子：タスクの状態がdone(完了)ならグレイ
        }.gesture(DragGesture().onChanged({ value in
            if value.predictedEndTranslation.width > 200 {
                if self.todo.state != ToDoEntity.State.done.rawValue{
                    self.todo.state = ToDoEntity.State.done.rawValue
                    }
                } else if value.predictedEndTranslation.width < -200 {
                    if self.todo.state != ToDoEntity.State.todo.rawValue {
                        self.todo.state = ToDoEntity.State.todo.rawValue
                    }
            }
        }))
    }
}

struct TodoDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        let newTodo = ToDoEntity(context: context)
        newTodo.task = "将来への人間関係づくり"
        newTodo.state = ToDoEntity.State.done.rawValue
        newTodo.category = 0
        let newTodo1 = ToDoEntity(context: context)
        newTodo1.task="クレームへの対応"
        newTodo.category = 1
        let newTodo2 = ToDoEntity(context: context)
        newTodo2.task="無意味な接待や付き合い"
        newTodo2.category = 2
        let newTodo3 = ToDoEntity(context: context)
        newTodo3.task="長時間、必要以上の息抜き"
        newTodo3.category = 3
        return VStack(alignment: .leading) {
            VStack {
                TodoDetailRow(todo: newTodo)
                TodoDetailRow(todo: newTodo, hideIcon: true)
                TodoDetailRow(todo: newTodo1)
                TodoDetailRow(todo: newTodo2)
                TodoDetailRow(todo: newTodo3)
            }.environment(\.managedObjectContext, context)
        }
    }
}
