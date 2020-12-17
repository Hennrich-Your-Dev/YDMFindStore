//
//  YDMFindStoreViewController+Map.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 27/11/20.
//

import UIKit
import MapKit
import CoreLocation

import YDB2WAssets
import YDB2WModels
import YDExtensions

extension YDMFindStoreViewController {
  func createMapGradient() {
    let gradientTop = CAGradientLayer()

    gradientTop.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 3)
    gradientTop.opacity = 0.75

    gradientTop.colors = [
      UIColor.black.withAlphaComponent(1).cgColor,
      UIColor.black.withAlphaComponent(0.7).cgColor,
      UIColor.black.withAlphaComponent(0.3).cgColor,
      UIColor.black.withAlphaComponent(0.0).cgColor
    ]
    gradientTop.locations = [0, 0.3, 0.6, 1]

    let height = view.frame.height / 5

    let gradientBottom = CAGradientLayer()
    gradientBottom.frame = CGRect(
      x: 0,
      y: view.frame.maxY - height,
      width: view.frame.width,
      height: height
    )
    gradientBottom.opacity = 0.75

    gradientBottom.colors = [
      UIColor.black.withAlphaComponent(0).cgColor,
      UIColor.black.withAlphaComponent(0.1).cgColor,
      UIColor.black.withAlphaComponent(0.5).cgColor,
      UIColor.black.withAlphaComponent(1).cgColor
    ]
    gradientBottom.locations = [0, 0.3, 0.6, 1]

    mapView?.layer.addSublayer(gradientTop)
    mapView?.layer.addSublayer(gradientBottom)
  }

  func zoomToPosition(
    _ coordinate: CLLocationCoordinate2D,
    withSpan span: MKCoordinateSpan? = nil,
    withRadius radius: Double = 200
  ) {
    var viewRegion = MKCoordinateRegion(
      center: coordinate,
      latitudinalMeters: radius * 2,
      longitudinalMeters: radius * 2
    )

    if let span = span {
      viewRegion = MKCoordinateRegion(
        center: coordinate,
        span: span
      )
    }

    mapView.setRegion(viewRegion, animated: true)
  }

  func fetchDirection(to store: YDStore) {
    guard let latitude = store.geolocation?.latitude,
          let longitude = store.geolocation?.longitude
    else {
      return
    }

    let request = MKDirections.Request()
    let coords = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    request.source = MKMapItem.forCurrentLocation()
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coords))

    request.transportType = .automobile

    let directions = MKDirections(request: request)

    directions.calculate { [weak self] response, error in
      guard let self = self,
            let response = response,
            let route = response.routes.first
      else {
        return
      }

      self.mapView.addOverlay(route.polyline)

      let wPadding = route.polyline.boundingMapRect.size.width * 0.55
      let hPadding = route.polyline.boundingMapRect.size.height * 0.25

      var rect = route.polyline.boundingMapRect
      rect.size.width += wPadding
      rect.size.height += hPadding

      rect.origin.x -= wPadding / 2
      rect.origin.y -= hPadding / 2

      self.mapView.setVisibleMapRect(rect, animated: true)
    }
  }

  func addPinsOnMap(with stores: [YDStore], shouldCenterMap: Bool = false) {
    mapView.removeAnnotations(mapView.annotations)
    annotations.removeAll()

    for store in stores {
      guard let latitude = store.geolocation?.latitude,
            let longitude = store.geolocation?.longitude
      else {
        continue
      }

      let annotation = MKPointAnnotation()
      annotation.coordinate = CLLocationCoordinate2D(
        latitude: latitude,
        longitude: longitude
      )

      mapView.addAnnotation(annotation)
      annotations.append(annotation)
    }

    mapView.addAnnotations(annotations)

    if shouldCenterMap,
       let selectedStore = stores.at(currentStoreIndex),
       let lat = selectedStore.geolocation?.latitude,
       let lng = selectedStore.geolocation?.longitude {

      let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
      zoomToPosition(coordinate, withSpan: mapView.region.span)
    }
  }

  func redrawPins(highlightAt index: Int, shouldCenterMap centering: Bool) {
    guard let stores = viewModel?.stores.value else {
      return
    }

    currentStoreIndex = index
    addPinsOnMap(with: stores, shouldCenterMap: centering)
  }
}

extension YDMFindStoreViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    if !alreadyPlaceCurrentLocationMarker {
      alreadyPlaceCurrentLocationMarker = true
      zoomToPosition(userLocation.coordinate)
    }
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
    renderer.strokeColor = UIColor.Zeplin.redBranding
    renderer.lineWidth = 2
    return renderer
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }

    if let largestAnnotation = annotations.at(currentStoreIndex),
       largestAnnotation.coordinate.latitude == annotation.coordinate.latitude &&
        largestAnnotation.coordinate.longitude == annotation.coordinate.longitude {
      return mapView.dequeueReusableAnnotationView(
        withIdentifier: CustomLargerAnnotation.identifier,
        for: annotation
      )

    } else {
      return mapView.dequeueReusableAnnotationView(
        withIdentifier: CustomSmallAnnotation.identifier,
        for: annotation
      )
    }
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard let annotation = view.annotation,
          let index = annotations.firstIndex(where: {
                                              $0.coordinate.latitude == annotation.coordinate.latitude &&
                                                $0.coordinate.longitude == annotation.coordinate.longitude
          })
    else {
      return
    }

    redrawPins(highlightAt: index, shouldCenterMap: true)
    collectionView.scrollToItem(
      at: IndexPath(row: index, section: 0),
      at: .centeredHorizontally,
      animated: true
    )
  }
}
