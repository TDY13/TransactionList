//
//  TransactionModel.swift
//  TransactionList
//
//  Created by Dima Tym on 31.10.2023.
//

import Foundation

// MARK: - TransactionElement
public struct TransactionElement: Codable {
    let id: Int
    let type: TypeEnum
    let amount: Double
    let currencyCode: CurrencyCode
    let date, accountNumber, transactionPurpose: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, amount
        case currencyCode = "currency_code"
        case date
        case accountNumber = "account_number"
        case transactionPurpose = "transaction_purpose"
        case description
    }
}

enum CurrencyCode: String, Codable {
    case mdl = "MDL"
}

enum TypeEnum: String, Codable {
    case income = "Income"
    case outcome = "Outcome"
}

extension TransactionElement {
    var formattedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: date)
    }
}
