//
//  TaskToday.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/25.
//

import SwiftUI

struct TaskToday: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoEntity.time,
                                           ascending: true)],
        predicate: NSPredicate(format:"time BETWEEN {%@ , %@}", Date.today as NSDate, Date.tomorrow as NSDate),
        animation: .default)
     var todoList: FetchedResults<ToDoEntity>

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("今日が期限のタスク").font(.footnote).bold().padding()
            List(todoList) { todo in
                TodoDetailRow(todo: todo)
            }
        }.background(Color(UIColor.systemBackground))
        .clipShape(RoundedCorners(topleft: 40, topright: 40, bottomleft: 0, bottomright: 0))
    }
}

struct TaskToday_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        
        
        TaskToday()
            .environment(\.managedObjectContext, context)
    }
}
