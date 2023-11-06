//
//  ContentView+Interactions.swift
//  TransactionList
//
//  Created by Dima Tym on 05.11.2023.
//

import Foundation

extension ContentView {
    public enum Interactions {
        case getData
        case updateTransaction(TransactionElement)
    }
}
