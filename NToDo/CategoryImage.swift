//
//  CategoryImage.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/02/28.
//

import SwiftUI

struct CategoryImage: View {
    
    var category: ToDoEntity.Category
    
    init (_ category: ToDoEntity.Category?){
        self.category = category ?? .ImpUrg_1st
    }
    
    var body: some View {
        Image(systemName: category.image())
            .resizable()
            .scaledToFit()//縦横比を揃える
            .foregroundColor(.white)
            .padding(2.0)
            .frame(width: 50, height:  50)//オプションの順序=優先度だから注意
            .background(category.color())
            .cornerRadius(10)
            
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(ToDoEntity.Category.ImpUrg_1st)
    }
}
