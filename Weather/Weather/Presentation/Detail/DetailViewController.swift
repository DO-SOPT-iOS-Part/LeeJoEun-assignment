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

    private let hourData: [[String]] = [["Now", "sun.max.fill", "21°"], ["10시", "cloud.drizzle.fill", "21°"], ["11시", "cloud.heavyrain.fill", "21°"], ["12시", "cloud.bolt.fill", "21°"], ["13시", "cloud.sun.rain.fill", "19°"], ["14시", "cloud.sleet.fill", "19°"], ["15시", "cloud.moon.fill", "19°"], ["16시", "cloud.moon.fill", "17°"], ["17시", "moon.fill", "17°"], ["18시", "moon.fill", "17°"]]

    private let dayData: [[Any]] = [["오늘", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar1,"29°"], ["월", "cloud.drizzle.fill", "45%", "15°", ImageLiterals.Detail.img_temparatureBar2,"29°"], ["화", "cloud.drizzle.fill", "65%", "15°", ImageLiterals.Detail.img_temparatureBar3,"29°"], ["수", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar4,"29°"], ["목", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar5,"29°"], ["금", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar5,"29°"], ["토", "cloud.drizzle.fill", "70%", "15°", ImageLiterals.Detail.img_temparatureBar3,"29°"], ["일", "cloud.drizzle.fill", "60%", "15°", ImageLiterals.Detail.img_temparatureBar2,"29°"], ["월", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar6,"29°"], ["화", "sun.max.fill", "0%", "15°", ImageLiterals.Detail.img_temparatureBar6,"29°"]]

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
        return hourData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherOfHourCell.identifier, for: indexPath) as? WeatherOfHourCell else {
            return UICollectionViewCell()
        }
        cell.setHourData(hour: hourData[indexPath.row][0],weather: hourData[indexPath.row][1], temperature: hourData[indexPath.row][2])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 122)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (dayData[indexPath.row][2] as! String != "0%") {
            guard let cell = detailView.weatherOfDayTableView.dequeueReusableCell(withIdentifier: RainyDayTableViewCell.identifier, for: indexPath) as? RainyDayTableViewCell else { return UITableViewCell() }
            cell.setRainyDayData(day: dayData[indexPath.row][0] as! String, weather: dayData[indexPath.row][1] as! String, percent: dayData[indexPath.row][2] as! String,min: dayData[indexPath.row][3] as! String, temperatureImage: dayData[indexPath.row][4] as! UIImage, max: dayData[indexPath.row][5] as! String)
            return cell
        }
        guard let cell = detailView.weatherOfDayTableView.dequeueReusableCell(withIdentifier: WeatherOfDayTableViewCell.identifier, for: indexPath) as? WeatherOfDayTableViewCell else { return UITableViewCell() }
        cell.setDayData(day: dayData[indexPath.row][0] as! String, weather: dayData[indexPath.row][1] as! String, min: dayData[indexPath.row][3] as! String, temperatureImage: dayData[indexPath.row][4] as! UIImage, max: dayData[indexPath.row][5] as! String)
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

