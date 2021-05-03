//
//  UIApplication+Extension.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/05/01.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
