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
        detailView.weatherOfHourCollectionView.delegate = self
        detailView.weatherOfHourCollectionView.dataSource = self
        detailView.weatherOfDayTableView.delegate = self
        detailView.weatherOfDayTableView.dataSource = self

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
        return 12
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailView.weatherOfDayTableView.dequeueReusableCell(withIdentifier: RainyDayTableViewCell.identifier, for: indexPath) as? RainyDayTableViewCell else { return UITableViewCell() }
        //cell.setData(text: infoArr[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeaderView: UIView = {
            let uiView = UIView()
            uiView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 38)
            return uiView
        }()

        let calendarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "calendar")
            imageView.tintColor = .WeatherWhite_2
            imageView.contentMode = .scaleAspectFit

            return imageView
        }()

        let tabelHeaderLabel: UILabel = {
            let label = UILabel()
            label.text = "10일간의 일기예보"
            label.font = UIFont.SFPro(size: 15, weight: .medium)
            label.textColor = .WeatherWhite_2

            return label
        }()

        tableHeaderView.addSubview(calendarImageView)
        tableHeaderView.addSubview(tabelHeaderLabel)

        calendarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(15)
            $0.size.equalTo(22)
        }
        tabelHeaderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalTo(calendarImageView.snp.trailing).offset(8)
        }

        return tableHeaderView
    }
}

