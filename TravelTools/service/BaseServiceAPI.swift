//
//  BaseServiceAPI.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 24/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


protocol BaseService {
    func request(urlPath: URL, completion: @escaping (ResultAPI<Data, String>) -> Void)
}


extension BaseService {
    func request(urlPath: URL, completion: @escaping (ResultAPI<Data, String>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlPath) { (data, response, error) in

            if let error = error {
                completion(ResultAPI.failure(error.localizedDescription))
            } else {
                completion(ResultAPI.success(data!))
            }
        }
        task.resume()
    }
}


