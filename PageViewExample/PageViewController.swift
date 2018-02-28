//
//  PageViewController.swift
//  PageViewExample
//
//  Created by Jingged on 2/28/18.
//  Copyright © 2018 PanthersTechnik. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var list = [Page]()
    var sb: UIStoryboard?
    var viewController: ViewController! // settting from ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        sb = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4, execute: {
            self.setupList()
        })
    }
    func setupList(){
        for i in 0..<100{
            let model = PageModel(title: "Title \(i + 1)", subTitle: "SubTitle \(i + 1)")
            let page = sb?.instantiateViewController(withIdentifier: "PageID") as! Page
            page.data = model
            page.pageIndex = i
            page.delegate = viewController
            list.append(page)
        }
        self.delegate = self
        self.dataSource = self
        setViewControllers([list[0]], direction: .forward, animated: true, completion: nil)
        self.updateCurrentPageLabel(index: 0)
    }
    func movePage(index: Int){
        let currentIndex = self.viewControllers![0] as! Page
        self.updateCurrentPageLabel(index: index)
        setViewControllers([list[index]], direction: index > currentIndex.pageIndex ? .forward : .reverse, animated: true)
    }
    func getCurrentPageIndex() -> Int{
        return (self.viewControllers![0] as! Page).pageIndex
    }
    func updateCurrentPageLabel(index: Int){
        (self.parent as? ViewController)?.currentListingLabel.text = "\(index + 1) of \(list.count)"
    }
}
extension PageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentIndex = (self.viewControllers![0] as! Page).pageIndex
        self.updateCurrentPageLabel(index: currentIndex)
        
    }
}
extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! Page).pageIndex
        if index > 0 {
            return list[index-1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! Page).pageIndex
        if index < list.count-1 {
            return list[index+1]
        }
        return nil
    }
    
}
