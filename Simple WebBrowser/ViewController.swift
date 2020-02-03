//
//  ViewController.swift
//  Simple WebBrowser
//
//  Created by DDDD on 02/02/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(openTapped))
        
 
                // creating the forward, back and newPage buttons
        let goForward = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goForward)
        let goBack = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goBack))
        let addNewPage = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openTapped))
              
                // creating the navigation loader UIProgressView
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressViewButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressViewButton, goBack, goForward, spacer, refresh, addNewPage]
        navigationController?.isToolbarHidden = false
       
        // adding KVO - key value observer
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    
    // introducing the function which allows to open pre-defined websites
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "bbc.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    
    
    
    
}

