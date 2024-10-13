//
//  VideoViewController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/13/24.
//

import Foundation
import WebKit

final class VideoViewController: BaseViewController {
    var url: URL?
    var webView = WKWebView()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    override func configureHierachy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadWebView() {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
