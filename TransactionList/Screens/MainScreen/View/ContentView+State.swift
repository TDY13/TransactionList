//
//  ContentView+State.swift
//  TransactionList
//
//  Created by Dima Tym on 05.11.2023.
//

import Foundation

extension ContentView {
    public struct State {
        var items: [TransactionElement]
        
        init(items: [TransactionElement]) {
            self.items = items
        }
    }
}
