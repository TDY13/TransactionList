//
//  TransactionListApp.swift
//  TransactionList
//
//  Created by Dima Tym on 31.10.2023.
//

import SwiftUI

@main
struct TransactionListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(transactionService: TransactionService()))
        }
    }
}
