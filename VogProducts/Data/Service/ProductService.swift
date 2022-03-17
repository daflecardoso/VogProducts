//
//  ProductService.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation
import RxSwift
import Moya

protocol ProductServiceContract {
    func products() -> Single<[Product]>
}

class ProductService: ProductServiceContract {
    
    private let provider = MoyaProvider<ProductAPI>()
    
    func products() -> Single<[Product]> {
        return provider.rx.request(.products).map([Product].self)
    }
}
