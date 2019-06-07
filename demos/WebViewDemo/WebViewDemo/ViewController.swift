//
//  ViewController.swift
//  WebViewSample
//
//  Created by Ernesto Elsäßer on 07.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        let url = URL(string: "https://bosch.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url,
            let host = url.host else {
                
            decisionHandler(.allow)
            return
        }
        
        if host.hasSuffix("bosch.com") {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        let alert = UIAlertController(title: "Navigation failed!", message: error.localizedDescription, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
