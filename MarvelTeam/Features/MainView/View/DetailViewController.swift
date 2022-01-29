//
//  DetailViewController.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 29/1/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var getImage: URL?
    var getName: String?
    var getDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLabel()
        setupImage()
       
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupLabel() {
        lblName.font = UIFont(name: "BebasNeue-Regular", size: 22)
        lblDescription.numberOfLines = 0
        lblDescription.lineBreakMode = .byWordWrapping
        lblName.text = getName
        lblDescription.sizeToFit()
        
        if getDescription! == "" {
            lblDescription.text = localizedString("text_image_empty")
            lblDescription.textColor = UIColor.white
        } else {
            lblDescription.text = getDescription
            lblName.textColor = UIColor.white
            lblDescription.textColor = UIColor.white
        }
        
    }
    
    func setupImage() {
        let imgData = "\(getImage!)" + Constants.imgExtension
        let url = URL(string: imgData)
        imgCharacter.contentMode = .scaleAspectFill
        if (url == nil || imgData.contains(Constants.imgNotAvailable))  {
            imgCharacter.image = UIImage(named: Constants.imgNotAvailable)
        } else {
            imgCharacter.image = UIImage(url: URL(string: imgData))
        }
    }
    
}
