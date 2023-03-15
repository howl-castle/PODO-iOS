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

final class WebViewViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        //webView.uiDelegate = self
//        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
}

extension WebViewViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("@@@@@ navigationAction: \(navigationAction)")
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("@@@@@ navigationResponse: \(navigationResponse)")
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("@@@@@ didReceiveServerRedirectForProvisionalNavigation")
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("@@@@@ didStartProvisionalNavigation")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("@@@@@ didCommit")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("@@@@@ didFinish")
    }
}

extension WebViewViewController: WKUIDelegate {

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("@@@@@ runJavaScriptAlertPanelWithMessage message: \(message)")
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("@@@@@ runJavaScriptConfirmPanelWithMessage message: \(message)")
    }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("@@@@@ runJavaScriptTextInputPanelWithPrompt prompt: \(prompt), defaultText: \(defaultText)")
    }

    func webView(_ webView: WKWebView, contextMenuConfigurationForElement elementInfo: WKContextMenuElementInfo, completionHandler: @escaping (UIContextMenuConfiguration?) -> Void) {
        print("@@@@@ contextMenuConfigurationForElement elementInfo: \(elementInfo)")
    }

    func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) {
        print("@@@@@ contextMenuWillPresentForElement elementInfo: \(elementInfo)")
    }

    func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating) {
        print("@@@@@ contextMenuForElement elementInfo: \(elementInfo)")
    }

    func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo) {
        print("@@@@@ contextMenuDidEndForElement elementInfo: \(elementInfo)")
    }
}

extension WebViewViewController {

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

        if let url = URL(string: "https://wallet.ton.org") {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }
}
