//
//  ProductsViewController.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProductsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let productCell = ProductCell.self
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(productCell, forCellReuseIdentifier: String(describing: ProductCell.self))
        return tableView
    }()
    
    var emptyView: UILabel = {
        let view = UILabel()
        view.text = "No items"
        return view
    }()
    
    private let viewModel: ProductsViewModel
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        viewModel.fetch()
    }
    
    private func setup() {
        setupConstraints()
        setupBinds()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupBinds() {
        viewModel
            .products
            .do(onNext: { [unowned self] products in
                emptyView.isHidden = products.count > 0
            }).drive(tableView.rx.items(cellIdentifier: String(describing: ProductCell.self),
                                      cellType: productCell)) { row, product, cell in
                cell.set(with: product)
                
            }.disposed(by: disposeBag)
    }
}

extension ProductsViewController {
    
    class ProductCell: UITableViewCell {
        
        private var productLabel: UILabel = {
            let label = UILabel()
            
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setup() {
            contentView.addSubview(productLabel)
            productLabel.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(16)
            }
        }
        
        func set(with item: Product) {
            productLabel.text = item.name + " " + item.priceFormatted
        }
    }
}
