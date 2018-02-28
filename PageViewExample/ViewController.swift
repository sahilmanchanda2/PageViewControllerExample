//
//  ViewController.swift
//  PageViewExample
//
//  Created by Jingged on 2/28/18.
//  Copyright © 2018 PanthersTechnik. All rights reserved.
//

import UIKit
protocol CallBack {
    func didReceive(withMessage message: String)
}
class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var currentListingLabel: UILabel!
    var pageController: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTags()
        setupActions()
        setupContainerView()
    }
    
    enum buttonTags: Int{
        case call = 1
        case message
        case next
        case back
    }
    func setupTags(){
        btnCall.tag = buttonTags.call.rawValue
        btnMessage.tag = buttonTags.message.rawValue
        btnNext.tag = buttonTags.next.rawValue
        btnBack.tag = buttonTags.back.rawValue
    }
    func setupActions(){
        btnCall.addTarget(self, action: #selector(self.didSelect(_:)), for: .touchUpInside)
        btnMessage.addTarget(self, action: #selector(self.didSelect(_:)), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(self.didSelect(_:)), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(self.didSelect(_:)), for: .touchUpInside)
    }
    @objc func didSelect(_ sender: UIView){
        if let tag = buttonTags.init(rawValue: sender.tag){
            switch tag{
            case .call:
                print("Call button called for index \(pageController?.getCurrentPageIndex() ?? 0)")
            case .message:
                print("message button called for index  \(pageController?.getCurrentPageIndex() ?? 0)")
            case .next:
                if let p = pageController{
                    let currentIndex = p.getCurrentPageIndex()
                    if currentIndex < p.list.count - 1{
                        p.movePage(index: currentIndex + 1)
                    }
                }
            case .back:
                if let p = pageController{
                    let currentIndex = p.getCurrentPageIndex()
                    if currentIndex > 0{
                        p.movePage(index: currentIndex - 1)
                    }
                }
            }
        }
    }
    func setupContainerView(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        pageController = sb.instantiateViewController(withIdentifier: "PageViewControllerID") as? PageViewController
        pageController?.viewController = self
        addViewIntoParentViewController(vc: pageController)
    }
    func addViewIntoParentViewController(vc: UIViewController?){
        if let vc = vc{
            for v in self.containerView.subviews{
                v.removeFromSuperview()
            }
            self.containerView.addSubview(vc.view)
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            addChildViewController(vc)
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
            vc.didMove(toParentViewController: self)
        }
    }
}
extension ViewController: CallBack{
    func didReceive(withMessage message: String) {
        print("message: \(message)")
    }
}

