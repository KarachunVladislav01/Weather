//
//  APIClient.swift
//  weatherApp
//
//  Created by Vladislav on 4/19/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation

enum Either<V, E: Error> {
    case value(V)
    case error(E)
}

enum SourceType: String{
    case internet = "itenet"
    case local = "local"
    
}

enum APIError: Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping(Either<V, APIError>) -> Void)
}

extension APIClient{
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping(Either<V, APIError>) -> Void) {
        print(request)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(.apiError))
                return
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(.badResponse))
                return
            }
            guard let value = try? JSONDecoder().decode(V.self, from: data!) else {
                completion(.error(.jsonDecoder))
                return
            }
            do{
                let url1 = getDocumentsURL().appendingPathComponent("posts.json")
                try data!.write(to: url1, options: [])
            } catch {
                fatalError(error.localizedDescription)
            }
            completion(.value(value))
        }
        task.resume()
    }
}
