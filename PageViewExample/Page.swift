//
//  Page.swift
//  PageViewExample
//
//  Created by Jingged on 2/28/18.
//  Copyright © 2018 PanthersTechnik. All rights reserved.
//
import UIKit

struct PageModel {
    var title: String
    var subTitle: String
}

class Page: PageViewBase {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnWorking: UIButton!
    var data: PageModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTags()
        setupActions()
        setupData()
    }
    func setupData(){
        if let data = data{
            self.titleLabel.text = data.title
            self.subTitleLabel.text = data.subTitle
            imageView.image = #imageLiteral(resourceName: "car")
        }
        
    }
    
    enum buttonTags: Int{
        case working = 1
    }
    func setupTags(){
        btnWorking.tag = buttonTags.working.rawValue
    }
    func setupActions(){
        btnWorking.addTarget(self, action: #selector(self.didSelect(_:)), for: .touchUpInside)
    }
    @objc func didSelect(_ sender: UIView){
        if let tag = buttonTags.init(rawValue: sender.tag){
            switch tag{
            case .working:
                delegate?.didReceive(withMessage: "wokring button clicked of index \(pageIndex)")
            }
        }
    }
}
