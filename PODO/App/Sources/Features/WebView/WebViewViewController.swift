//
//  WebViewViewController.swift
//  PODO
//
//  Created by Ethan on 2023/03/13.
//

import UIKit
import SnapKit
import Then
import WebKit

final class WebViewViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupWebView()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .white
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.webView)
        }
    }

    private func setupWebView() {
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.webView.do {
            if let url = URL(string: "https://phantom.app/ul/v1/connect") {
                let request = URLRequest(url: url)
                $0.load(request)
            }
        }
    }

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        //webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
}
