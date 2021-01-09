//
//  YDMFindStorePreStartViewController.swift
//  YDMFindStore
//
//  Created by Douglas on 09/01/21.
//

import UIKit

import YDB2WAssets

class YDMFindStorePreStartViewController: UIViewController {
  // MARK: Properties
  
  // MARK: IBOutlets
  @IBOutlet weak var backButton: UIButton! {
    didSet {
      backButton.layer.cornerRadius = backButton.frame.height / 2
      backButton.setImage(Icons.times, for: .normal)
    }
  }
  
  @IBOutlet weak var iconImageView: UIImageView! {
    didSet {
      iconImageView.image = Icons.map
    }
  }
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var actionButton: UIButton! {
    didSet {
      actionButton.layer.borderWidth = 1
      actionButton.layer.borderColor = UIColor.white.cgColor
      actionButton.layer.cornerRadius = 4
    }
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: IBActions
  @IBAction func onBackAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onButtonAction(_ sender: UIButton) {
    
  }
}
