//
//  DescriptionViewModel.swift
//  TransactionList
//
//  Created by Dima Tym on 01.11.2023.
//

import Foundation

@MainActor
class DescriptionViewModel: ObservableObject {
    @Published public var state: DescriptionView.State
    @MainActor public var outputHandler: OutputClosure
    
    init(item: TransactionElement, outputHandler: @escaping OutputClosure) {
        self.state = .init(item: item, isActiveChanges: false)
        self.outputHandler = outputHandler
    }
    
    func handle(_ interaction: DescriptionView.Interactions) {
        switch interaction {
        case let .changeDescription(description):
            var newState = state
            newState.isActiveChanges = true
            newState.item.description = description
            state = newState
            
        case .save:
            self.outputHandler(.change(self.state.item))
            
            /*
             There would be a service that would send transaction changes to the server.
             Function is for example.
             */
            
//            NetworkManager().sendTransaction(url: serverURL,
//                                             method: .post,
//                                             transaction: self.state.item,
//                                             completion: <#T##(Result<[TransactionElement], NetworkError>) -> Void#>)
        }
    }
}

public enum DescriptionOutput {
    case change(TransactionElement)
}

extension DescriptionViewModel {
    typealias OutputClosure = (DescriptionOutput) -> Void
}
