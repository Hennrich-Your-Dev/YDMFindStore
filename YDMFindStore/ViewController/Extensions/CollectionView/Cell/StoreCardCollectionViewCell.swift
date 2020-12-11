//
//  StoreCardCollectionViewCell.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 11/12/20.
//

import UIKit

import YDExtensions
import YDB2WModels
import YDB2WAssets

class YDMFindStoreStoreCardCollectionViewCell: UICollectionViewCell {

  // MARK: Properties
  private var grayColor = UIColor(
    red: 102 / 255,
    green: 102 / 255,
    blue: 102 / 255,
    alpha: 1
  )

  var store: YDStore?

  // MARK: IBOutlets
  @IBOutlet weak var logoImageView: UIImageView!

  @IBOutlet weak var storeLabel: UILabel!

  @IBOutlet weak var addressLabel: UILabel!

  @IBOutlet weak var timeLabel: UILabel!

  @IBOutlet weak var productsButton: UIButton! {
    didSet {
      productsButton.layer.cornerRadius = 4
      productsButton.layer.borderWidth = 1.5
      productsButton.layer.borderColor = grayColor.cgColor
      productsButton.tintColor = grayColor

      productsButton.setImage(Icons.basket, for: .normal)
      productsButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
    }
  }

  @IBOutlet weak var whatsappButton: UIButton! {
    didSet {
      whatsappButton.layer.cornerRadius = 4
      whatsappButton.layer.borderWidth = 1.5
      whatsappButton.layer.borderColor = grayColor.cgColor
      whatsappButton.tintColor = grayColor
    }
  }

  @IBOutlet weak var distanceContainer: UIView! {
    didSet {
      distanceContainer.layer.cornerRadius = 6
    }
  }

  @IBOutlet weak var distanceLabel: UILabel!

  // MARK: Life cycle
  override func awakeFromNib() {
    super.awakeFromNib()

    layer.applyShadow()
    layer.cornerRadius = 8
  }

  // MARK: IBActions
  @IBAction func onProductsAction(_ sender: Any) {
  }

  @IBAction func onWhatsappAction(_ sender: Any) {
  }

  // MARK: Actions
  public func config(with store: YDStore) {
    self.store = store
  }

}
