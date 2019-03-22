//
//  CurrencyExchangeAPI.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 24/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


struct CurrencyService: BaseService {


    func requestCurrency(endPoint: BaseEndPoint, completion: @escaping (ResultAPI<Double, String>) -> Void) {

        let url = URL(string: endPoint.url + endPoint.path)!

        self.request(urlPath: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    guard let usds = json!["quotes"] as? [String: Any], let usdBRL = usds["USDBRL"] as? Double else {
                        completion(ResultAPI.failure("Error to get value"))
                        return
                    }

                    completion(ResultAPI.success(usdBRL))

                } catch(let error) {
                    completion(ResultAPI.failure(error.localizedDescription))
                }

            case .failure(let error):
                completion(ResultAPI.failure(error))
            }

        }

    }
}
