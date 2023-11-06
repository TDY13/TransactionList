//
//  DescriptionView+State.swift
//  TransactionList
//
//  Created by Dima Tym on 01.11.2023.
//

import Foundation

extension DescriptionView {
    public struct State {
        var item: TransactionElement
        var isActiveChanges: Bool
        
        init(item: TransactionElement, isActiveChanges: Bool) {
            self.item = item
            self.isActiveChanges = isActiveChanges
        }
    }
}
