//
//  YDMFindStoreViewController+CollectionView.swift
//  YDMFindStore
//
//  Created by Douglas Hennrich on 11/12/20.
//

import UIKit

import YDExtensions

// MARK: Data Source
extension YDMFindStoreViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let stores = viewModel?.stores.value else {
      storesListContainer.isHidden = true
      return 0
    }

    storesListContainer.isHidden = stores.isEmpty
    return stores.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YDMFindStoreStoreCardCollectionViewCell.identifier, for: indexPath) as? YDMFindStoreStoreCardCollectionViewCell,
          let store = viewModel?[indexPath.row]
    else {
      fatalError()
    }

    cell.config(with: store)
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    switch kind {

    case UICollectionView.elementKindSectionHeader:

      let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "Header",
        for: indexPath
      )
      return headerView

    case UICollectionView.elementKindSectionFooter:
      let footerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "Footer",
        for: indexPath
      )
      return footerView

    default:
      fatalError("Header Section")
    }
  }
}

// MARK: Delegate
extension YDMFindStoreViewController: UICollectionViewDelegate {

}
