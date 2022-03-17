//
//  ProductAPI.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation
import Moya

enum ProductAPI {
    case products
}

extension ProductAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.devplayground.app")!
    }
    
    var path: String {
        switch self {
        case .products:
            return "/api/v1/project/products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .products:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .products:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
}
