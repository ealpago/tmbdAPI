//
//  BaseSceneDelegate.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 22.06.2023.
//
import UIKit

public enum AlertStatus{
    case success
    case info
    case warning
    case error
}

open class BaseSceneDelegate: UIResponder, UIWindowSceneDelegate {
    public var rootViewController:UIViewController?
    public var window: UIWindow?
    public var didNetworkStatusChange:(Bool)->() = {status in}
    let LOADING_VIEW_TAG = 998

    private var animationBackgroundView:UIView?
    private var animationView:UIActivityIndicatorView?
    public var activityIndicatorColor = UIColor.white

    open func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        window?.rootViewController = "LaunchScreen".initialViewController
//        window?.makeKeyAndVisible()
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.startMonitoring()
        guard let _ = (scene as? UIWindowScene) else { return }
    }


    public func sceneDidDisconnect(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
    }

    func startLoading(){
        guard createAnimationBackgroundView() != nil else {
            return
        }

        guard createAnimationView() != nil else {
            return
        }

        animationView?.startAnimating()
    }

    func stopLoading(){
        guard let window = window else {
            return
        }

        guard window.subviews.contains(where: {$0.tag == LOADING_VIEW_TAG}) else {
            return
        }

        animationView?.stopAnimating()
        animationBackgroundView?.isHidden = true
        animationView?.isHidden = true
        animationView?.removeFromSuperview()
        animationBackgroundView?.removeFromSuperview()
    }


    private func createAnimationBackgroundView() -> UIView? {
        guard let window = window else {
            return nil
        }
        if window.subviews.contains(where: {$0.tag == LOADING_VIEW_TAG}) {
            return nil
        }
        animationBackgroundView = UIView(frame: window.frame)
        animationBackgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.4)
        animationBackgroundView?.tag = LOADING_VIEW_TAG
        window.addSubview(animationBackgroundView!)
        window.bringSubviewToFront(animationBackgroundView!)
        return animationBackgroundView
    }

    private func createAnimationView() -> UIActivityIndicatorView? {
        guard let backgroundView = animationBackgroundView else {
            return nil
        }
        animationView = UIActivityIndicatorView(style: .large)
        animationView?.color = activityIndicatorColor
        animationView?.hidesWhenStopped = true
        animationView?.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        animationView?.center = backgroundView.center
        animationBackgroundView?.addSubview(animationView!)
        return animationView
    }

    public func setRootViewController(_ vc:UIViewController){
        self.rootViewController = vc
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

    open func refreshToken<T:Codable>(request:URLRequest, completion: @escaping(Swift.Result<T?, CustomError>)-> ()){

    }
}


extension BaseSceneDelegate:NetworkMonitorDelegate{
    public func networkStatusChange(status: Bool) {
        didNetworkStatusChange(status)
    }


}
