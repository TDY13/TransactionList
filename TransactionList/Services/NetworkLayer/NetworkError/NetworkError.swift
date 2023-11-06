//
//  NetworkError.swift
//  TransactionList
//
//  Created by Dima Tym on 01.11.2023.
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case encodingError(Error)
    case networkError(Error)
    case unknownError
    case httpError(Int)
}
