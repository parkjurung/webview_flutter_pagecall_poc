import WebKit

public class PagecallWebView: WKWebView, WKScriptMessageHandler {
    var nativeBridge: NativeBridge?
    var controllerName = "pagecall"
    var contentController: WKUserContentController?

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("PagecallSDK: PagecallWebView cannot be instantiated from a storyboard")
    }

    override public init(frame: CGRect, configuration: WKWebViewConfiguration) {
        self.contentController = configuration.userContentController;
        
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.allowsInlineMediaPlayback = true
        configuration.suppressesIncrementalRendering = false
        configuration.applicationNameForUserAgent = "PagecallIos"
        configuration.allowsAirPlayForMediaPlayback = true

        if #available(iOS 13.0, *) {
            configuration.defaultWebpagePreferences.preferredContentMode = .mobile
        }
        // if #available(iOS 14.0, *) {
        //     configuration.limitsNavigationsToAppBoundDomains = true
        // }
        super.init(frame: frame, configuration: configuration)

        self.allowsBackForwardNavigationGestures = false
        
        // 창 이동 문제가 있었다. flutter_inappwebview 에서도 마찬가지로..그래서 주석처리함
        // 웅진측에서 customUserAgent를 알아서 넣어줌.
        // if #available(iOS 15.0, *) {
        //     let osVersion = UIDevice.current.systemVersion
        //     self.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(osVersion) Safari/605.1.15"
        // }
        
        if let path = Bundle(for: PagecallWebView.self).path(forResource: "PagecallNative", ofType: "js") {
            if let bindingJS = try? String(contentsOfFile: path, encoding: .utf8) {
                let script = WKUserScript(source: bindingJS, injectionTime: .atDocumentStart, forMainFrameOnly: false)
                contentController?.addUserScript(script)
            }
        } else {
            NSLog("Failed to add PagecallNative script")
            return
        }

        contentController?.add(self, name: self.controllerName)
    }

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case self.controllerName:
            if let body = message.body as? String {
                self.nativeBridge?.messageHandler(message: body)
            }
        default:
            break
        }
    }

    public override func didMoveToSuperview() {
        if self.superview == nil {
            self.disposePagecall()
            return
        }

        if self.nativeBridge == nil {
            self.nativeBridge = .init(webview: self)
        }
    }

    private func disposePagecall() {
        self.nativeBridge?.disconnect()
        self.nativeBridge = nil
        self.contentController?.removeScriptMessageHandler(forName: self.controllerName)
    }
    public func dispose() {
        self.disposePagecall()
    }
}
