//
//  ContentViewModel.swift
//  TransactionList
//
//  Created by Dima Tym on 05.11.2023.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published public var state: ContentView.State
    
    let transactionService: TransactionServiceProtocol
    
    init(transactionService: TransactionServiceProtocol) {
        self.transactionService = transactionService
        self.state = .init(items: [])
    }
    
    func handle(_ interaction: ContentView.Interactions) {
        switch interaction {
        case .getData:
            var newState = state
            self.transactionService.getTransactions()
            switch self.transactionService.state {
            case .empty, .failure:
                newState = .init(items: [])
                
            case let .ready(content):
                let sortedTransactions = content.sorted {
                    if let date1 = $0.formattedDate, let date2 = $1.formattedDate {
                        return date1 < date2
                    }
                    return false
                }
                newState = .init(items: sortedTransactions)
            }
            state = newState
            
        case let .updateTransaction(transaction):
            var newState = state
            for (index, item) in newState.items.enumerated() where item.id == transaction.id {
                newState.items[index] = transaction
            }
            state = newState
        }
    }
}
