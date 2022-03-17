//
//  ProductsViewControllerTests.swift
//  VogProductsTests
//
//  Created by Dafle on 17/03/22.
//

import XCTest
@testable import VogProducts

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        }
    }
}

class ProductsViewControllerTests: XCTestCase {

    private var window: UIWindow? = UIApplication.keyWindow
    
    private func makeViewInstance(responseType: FakeProductService.ResponseType) -> ProductsViewController {
        let successFakeService = FakeProductService(responseType: responseType)
        let viewModel = ProductsViewModel(productsService: successFakeService)
        return ProductsViewController(viewModel: viewModel)
    }
    
    func testNumberOfLinesInMyTableView() {
        let viewController = makeViewInstance(responseType: .success)
        window?.rootViewController = viewController
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 4)
    }
    
    func testWhenAPIReturnEmpty() {
        let viewController = makeViewInstance(responseType: .empty)
        window?.rootViewController = viewController
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testWhenAPIReturnError() {
        let viewController = makeViewInstance(responseType: .error)
        window?.rootViewController = viewController
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testIfEmptyViewISShowingWhenMyAPIReturnZeroItems() {
        let viewController = makeViewInstance(responseType: .empty)
        window?.rootViewController = viewController
        
        XCTAssertEqual(viewController.emptyView.isHidden, false)
    }
    
    func testIfEmptyViewISHiddenWhenMyAPIReturnItems() {
        let viewController = makeViewInstance(responseType: .success)
        window?.rootViewController = viewController
        
        XCTAssertEqual(viewController.emptyView.isHidden, true)
    }
}
