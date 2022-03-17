//
//  ProductTests.swift
//  VogProductsTests
//
//  Created by Dafle on 17/03/22.
//

import XCTest
@testable import VogProducts

class ProductTest: XCTestCase {
    
    func testIfProductPriceFormattIsRight() {
        let product = Product(id: 1, name: "", price: 1000, imageUrl: "", color: "")
        XCTAssertEqual(product.priceFormatted, "$ 1000")
    }
}
