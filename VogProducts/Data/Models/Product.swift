//
//  Product.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let price: Int
    let imageUrl: String
    let color: String
    
    var priceFormatted: String {
        return "$ \(price)"
    }
}
