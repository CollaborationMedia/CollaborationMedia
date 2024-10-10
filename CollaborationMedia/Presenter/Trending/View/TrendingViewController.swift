//
//  TrendingViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit

class TrendingViewController: BaseViewController {
    private let tvBarButtonItem = UIBarButtonItem(image: Image.sparklesTV.rawValue)
    private let searchBarButtonItem = UIBarButtonItem(image: Image.magnifyingglass.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
    }

}

private extension TrendingViewController {
    func setNavi() {
        navigationItem.rightBarButtonItems = [tvBarButtonItem, searchBarButtonItem]
        navigationController?.navigationBar.tintColor = .white
    }
}
