//
//  CheckBox.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/03/01.
//

import SwiftUI

struct CheckBox<Label>: View where Label : View{
    //他のViewから値を受け取るためのステートメント
    @Binding var checked: Bool
    
    private var label: ()-> Label
    
    public init(checked: Binding<Bool>,
                @ViewBuilder label : @escaping () -> Label)
    {
        //Binding構造体に直接アクセスする場合には_をつける
        self._checked = checked
        self.label = label
    }
    
    
    var body: some View {
        //HStack:要素を横に並べる
        HStack{
            Image(systemName: checked ? "checkmark.circle" : "circle")
                .onTapGesture {
                    //Toggleで判定を切り替え
                    self.checked.toggle()
                }
            label()
        }
    }
}

//開発時のみ利用できるプレビュー用の構造体
struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        //VStack:要素を縦に並べる
        VStack {
            CheckBox(checked: .constant(false)){
                Text("Fuck you")
            }
            CheckBox(checked: .constant(false)){
                Image(systemName: "hand.thumbsup")
            }
            
        }
    }
}
