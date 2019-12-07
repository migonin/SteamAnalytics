//
//  LoginViewController.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import UICommon
import SnapKit
import WebKit

class LoginViewController: BaseViewController, LoginViewInput {

    // MARK: Properties
    var output: LoginViewOutput!

    private let webView = WKWebView()

    // MARK: Setup UI
    override func loadView() {
        super.loadView()

        setupNavBar()
        setupWebView()
    }

    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPage))
    }

    func setFakeLoginButtonHidden(_ hidden: Bool) {
        if hidden{
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.Login.fakeLogin, style: .plain, target: self, action: #selector(fakeLogin))

        }
    }

    private func setupWebView() {
        webView.navigationDelegate = self

        view.insertSubview(webView, belowSubview: hidingView)

        webView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        output.didLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output.willAppear(animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        output.didAppear(animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        output.willDisappear(animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        output.didDisappear(animated: animated)
    }

    @objc func reloadPage() {
        output.reloadTapped()
    }

    @objc func fakeLogin() {
        output.fakeLoginTapped()
    }

    // MARK: - WebViewSignInViewInput

    func loadRequest(_ request: URLRequest) {
        webView.load(request)
    }

    override func errorAlertRetryButtonTapped() {
        output.didTapRetryButton()
    }
}

// MARK: - WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        let isShouldStartLoad = output.shouldStartLoad(url: navigationAction.request.url)
        decisionHandler(isShouldStartLoad ? .allow : .cancel)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        output.didStartLoad(url: webView.url)
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        output.didFinishLoad(url: webView.url)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        output.didFailLoad(url: webView.url, with: error)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        output.didFailLoad(url: webView.url, with: error)
    }
}
