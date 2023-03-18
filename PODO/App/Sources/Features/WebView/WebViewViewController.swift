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
        self.modalPresentationStyle = .overCurrentContext
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadWebView()
    }

    func setupURL(_ url: URL?) {
        self.url = url
    }

    private func loadWebView() {
        guard let url = self.url else { return }

        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    private var url: URL?

    private let dimView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
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

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        if let url = navigationAction.request.url {
            UIApplication.shared.open(url)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: false)
        }

        return nil
    }

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
        //self.setupDimView()
        //self.setupContainerView()
        self.setupWebView()
        //self.setupTitleLabel()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.webView)
        }
    }

    private func setupDimView() {
        self.dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.dimView.do {
            $0.backgroundColor = .black2Opacity80
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.24)
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(45.0)
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10.0
        }
    }

    private func setupWebView() {
        self.webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.webView.do {
            $0.clipsToBounds = true
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30.0)
            $0.leading.equalTo(12.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 20.0, weight: .medium)
            $0.textColor = .white1
            $0.textAlignment = .center
            $0.text = "Open Tonkeeper for Connect Wallet"
        }
    }
}
