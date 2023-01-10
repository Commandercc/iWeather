//
//  CCWebView.swift
//  thunder
//
//  Created by zhengxu on 2022/2/23.
//

import Foundation
import WebKit

class CCWebView: CCBaseViewController {
    var loadFinishClosure: ((String) -> Void)?
    var targetUrl: String = ""
    var webView: WKWebView
    var navigationTitle: String = ""
    
    init(url: String, navigationTitle: String = "正在浏览h5页面") {
        self.webView = WKWebView(frame: CGRect(x: 0, y: .navBarHeight, width: .screenWidth, height: .screenHeight - .navBarHeight - .tabBarHeight))
        self.targetUrl = url
        self.navigationTitle = navigationTitle
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        //self.changeNavigationBarAlpha(alpha: 1)
        self.navigationController?.toTranslucent(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.navigationTitle
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        self.webView.navigationDelegate = self
        showWebPage()
    }
    
    private func showWebPage() {
        let url = URL(string: self.targetUrl)
        if let url = url {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
    
    deinit {
        CC.log("deinit ", "deinit")
    }
}

extension CCWebView: WKNavigationDelegate {
    // 页面加载完成调用，会将当前页面的url回调出去，供外面使用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let url = webView.url?.absoluteURL.absoluteString ?? ""
        if let blk = self.loadFinishClosure {
            blk(url)
        }
    }
}
