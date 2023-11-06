//
//  NetworkManager.swift
//  TransactionList
//
//  Created by Dima Tym on 31.10.2023.
//

import Foundation
import Alamofire

protocol NetworkLayerProtocol {
    associatedtype Response: Decodable
    func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping (Result<Response, NetworkError>) -> Void)
    func sendTransaction(url: URLConvertible, method: HTTPMethod, transaction: TransactionElement, headers: HTTPHeaders?, completion: @escaping (Result<Response, NetworkError>) -> Void)
}

extension NetworkLayerProtocol where Response: Decodable {
    func request(url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        AF.request(url, method: method, parameters: parameters, headers: headers).responseData { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}

extension NetworkLayerProtocol where Response: Decodable {
    func sendTransaction(url: URLConvertible, method: HTTPMethod, transaction: TransactionElement, headers: HTTPHeaders?, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(transaction)
            
            AF.upload(encodedData, to: url, method: method, headers: headers)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decodedObject = try JSONDecoder().decode(Response.self, from: data)
                            completion(.success(decodedObject))
                        } catch {
                            completion(.failure(.decodingError))
                        }
                        
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            completion(.failure(.httpError(statusCode)))
                        } else {
                            completion(.failure(.networkError(error)))
                        }
                    }
            }
        } catch let encodingError {
            completion(.failure(.encodingError(encodingError)))
        }
    }
}

struct NetworkManager: NetworkLayerProtocol {
    typealias Response = [TransactionElement]
}
