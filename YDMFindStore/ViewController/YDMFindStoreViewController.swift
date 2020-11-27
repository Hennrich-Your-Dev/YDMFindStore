//
//  YDMFindStoreViewController.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit
import YDUtilities
import YDExtensions

class YDMFindStoreViewController: UIViewController {
  // MARK: Properties
  var viewModel: YDMFindStoreViewModelDelegate?

  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    createMapGradient()
  }

  // MARK: IBOutlets
  @IBOutlet weak var mapView: MKMapView!

}

// MARK: Actions
extension YDMFindStoreViewController {

}
