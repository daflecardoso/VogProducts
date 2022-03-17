//
//  ProductsViewModel.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation
import RxSwift
import RxCocoa

class ProductsViewModel {
    
    private let disposeBag = DisposeBag()
    private let productsService: ProductServiceContract
    
    init(productsService: ProductServiceContract) {
        self.productsService = productsService
    }
    
    private let _products = PublishSubject<[Product]>()
    var products: Driver<[Product]> {
        return _products.asDriver(onErrorJustReturn: [])
    }
    
    func fetch() {
        productsService
            .products()
            .subscribe(onSuccess: { [unowned self] products in
                self._products.onNext(products)
            }, onFailure: { error in
                
            }).disposed(by: disposeBag)
    }
}
