//
//  BaseViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierachy()
        configureLayout()
        bind()
    }
    
    func configureHierachy() { }
    func configureLayout() { }
    func bind() { }
}
