//
//  DetailViewController.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

final class DetailViewController: UIViewController {
    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.delegateList = self
        detailView.WeatherOfHourCollectionView.delegate = self
        detailView.WeatherOfHourCollectionView.dataSource = self

        setHierarchy()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }

    func setHierarchy() {
        self.view.addSubview(detailView)
    }

    func setConstraints() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DetailViewController: PushMainViewDelegate {
    func listButtonTapped() {
        print("listButtonTapped")
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                      UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherOfHourCell.identifier, for: indexPath) as? WeatherOfHourCell else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 122)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
