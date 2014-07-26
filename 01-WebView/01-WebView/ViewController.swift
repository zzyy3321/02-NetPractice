//
//  ViewController.swift
//  01-WebView
//
//  Created by 刘凡 on 14/7/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIWebViewDelegate {
    
    var webView: UIWebView?
    var backButton: UIBarButtonItem?
    var forwardButton: UIBarButtonItem?
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 搜索栏
        var searchBar = UISearchBar()
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        // WebView
        var webView = UIWebView()
        webView.delegate = self
        self.view.addSubview(webView)
        self.webView = webView
        
        // 底部工具栏
        var toolBar = UIToolbar()
        self.view.addSubview(toolBar)
        
        self.backButton = UIBarButtonItem(title: "后退", style: .Bordered, target: webView, action: "goBack")
        self.backButton!.enabled = false
        var spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        self.forwardButton = UIBarButtonItem(title: "前进", style: .Bordered, target: webView, action: "goForward")
        self.forwardButton!.enabled = false
        toolBar.items = [self.backButton!, spaceButton, self.forwardButton!]
        
        // 自动布局
        searchBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        toolBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var views:NSDictionary = ["topGuide":self.topLayoutGuide, "searchBar": searchBar, "webView": webView, "toolBar": toolBar]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-0-[searchBar]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-0-[webView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-0-[toolBar]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide]-[searchBar(44)]-[webView]-[toolBar(44)]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
        // *** 在loadView时，self.topLayoutGuide.length = 0，需要重新布局才能够有值
        self.view.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebViewWithText("http://m.baidu.com")
    }
    
    // MARK: - 私有方法
    func loadWebViewWithText(text: String) {
        var urlStr = text
        if (!text.hasPrefix("http://")) {
            urlStr = "http://m.baidu.com/s?word=\(text)".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        }
        var url = NSURL(string: urlStr)
        self.webView!.loadRequest(NSURLRequest(URL: url))
    }
    
    // MARK: - 搜索栏代理方法
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        loadWebViewWithText(searchBar.text)
    }
    
    // MARK: - UIWebView代理方法
    func webViewDidFinishLoad(webView: UIWebView!) {
        self.backButton!.enabled = webView.canGoBack
        self.forwardButton!.enabled = webView.canGoForward
    }
}

