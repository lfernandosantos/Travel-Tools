//
//  BaseAPI.swift
//  TravelTools
//
//  Created by Luiz Fernando dos Santos on 24/02/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation


protocol BaseAPI {
    var url: String { get }
    var path: String { get }
}

enum BaseEndPoint {
    case live
}
extension BaseEndPoint: BaseAPI {
    var url: String {
        return "http://www.apilayer.net/api/"
    }

    var path: String {
        switch self {
        case .live:
            return "live?access_key=a217df6a11e53e7157b42b289d6c46de&format=1"
        }
    }

}


public enum ResultAPI<T, String> {
    case success(T)
    case failure(String)
}
