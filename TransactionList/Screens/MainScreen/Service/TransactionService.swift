//
//  TransactionService.swift
//  TransactionList
//
//  Created by Dima Tym on 01.11.2023.
//

import Foundation

public protocol TransactionServiceProtocol {
    var state: TransactionService.State { get }
    func getTransactions()
}

extension TransactionService {
    public enum State {
        case empty
        case ready([TransactionElement])
        case failure
    }
}

public class TransactionService: TransactionServiceProtocol {
    public var state: State
    private var networkManager = NetworkManager()
    private let apiURL = "https://raw.githubusercontent.com/TDY13/TransactionList/main/transactionList.json"
    
    init() {
        self.state = .empty
        self.getTransactions()
    }
    
    public func getTransactions() {
        networkManager.request(url: apiURL) { (result: Result<[TransactionElement], NetworkError>) in
            switch result {
            case let .success(content):
                self.state = .ready(content)
            case .failure:
                self.state = .failure
            }
        }
    }
}
