//
//  MainViewController.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    let mainView = MainView()
    let countryArr: [String] = ["seoul", "gunsan", "mokpo", "busan", "jeju"]
    lazy var weatherData: [WeatherDTO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true

        mainView.weatherTableView.delegate = self
        mainView.weatherTableView.dataSource = self

        setHierarchy()
        setConstraints()

        getWeather(countryArr)
    }

    func setHierarchy() {
        self.view.addSubview(mainView)
    }

    func setConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.weatherTableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        cell.setData(city: weatherData[indexPath.row].name,
                     time: Double(weatherData[indexPath.row].dt),
                     temp: weatherData[indexPath.row].main.temp,
                     temp_min: weatherData[indexPath.row].main.tempMin,
                     temp_max: weatherData[indexPath.row].main.tempMax,
                     weather: weatherData[indexPath.row].weather[0].main)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        let nextVC = DetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController {
    func getWeather(_ countryArr: [String]) {
        for i in 0...countryArr.count-1 {
            let country = countryArr[i]
            WeatherService().getWeather(country: country) { result in
                switch result {
                case .success(let weatherResponse):
                    DispatchQueue.main.async {
                        self.weatherData.append(weatherResponse)
                        self.mainView.weatherTableView.reloadData()
                    }
                case .failure(let error):
                    print("API Error: \(error)")
                }
            }
        }
        self.mainView.weatherTableView.reloadData()
    }
}
