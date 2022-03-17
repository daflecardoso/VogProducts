//
//  ProductsViewModelTests.swift
//  VogProductsTests
//
//  Created by Dafle on 17/03/22.
//

import XCTest
import RxSwift
@testable import VogProducts

class FakeProductService: ProductServiceContract {
    
    enum ResponseType {
        case success, empty, error
    }
    
    enum ServiceError: Error {
        case something
    }
    
    private let responseType: ResponseType
    
    init(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func products() -> Single<[Product]> {
        switch responseType {
        case .success:
            return Single.just([
                .init(id: 1, name: "iphone", price: 99999, imageUrl: "", color: "black"),
                .init(id: 1, name: "iphone", price: 99999, imageUrl: "", color: "black"),
                .init(id: 1, name: "iphone", price: 99999, imageUrl: "", color: "black"),
                .init(id: 1, name: "iphone", price: 99999, imageUrl: "", color: "black")
            ])
        case .empty:
            return Single.just([])
        case .error:
            return Single.error(ServiceError.something)
        }
    }
}

class ProductsViewModelTests: XCTestCase {
    
    private let disposeBag = DisposeBag()

    func testIfContainsFourItem() {
        let fakeService = FakeProductService(responseType: .success)
        let viewModel = ProductsViewModel(productsService: fakeService)
        
        var products: [Product] = []
        
        viewModel
            .products
            .drive(onNext: { _products in
                products = _products
            }).disposed(by: disposeBag)
        
        viewModel.fetch()
        
        XCTAssertEqual(products.count, 4)
    }
    
    func testIfAPIReturnEmptyItems() {
        let fakeService = FakeProductService(responseType: .empty)
        let viewModel = ProductsViewModel(productsService: fakeService)
        
        var products: [Product] = []
        
        viewModel
            .products
            .drive(onNext: { _products in
                products = _products
            }).disposed(by: disposeBag)
        
        viewModel.fetch()
        
        XCTAssertEqual(products.count, 0)
    }
    
    func testCountItemsIfAPIReturnError() {
        let fakeService = FakeProductService(responseType: .error)
        let viewModel = ProductsViewModel(productsService: fakeService)
        
        var products: [Product] = []
        
        viewModel
            .products
            .drive(onNext: { _products in
                products = _products
            }).disposed(by: disposeBag)
        
        viewModel.fetch()
        
        XCTAssertEqual(products.count, 0)
    }
}
