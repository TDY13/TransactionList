//
//  UIView+Extension.swift
//  TransactionList
//
//  Created by Dima Tym on 05.11.2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
