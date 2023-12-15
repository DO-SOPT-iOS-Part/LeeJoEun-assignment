//
//  MainViewModel.swift
//  Weather
//
//  Created by 이조은 on 12/15/23.
//

import UIKit

final class MainViewModel: NSObject{
    let countryArr: [String] = ["seoul", "gunsan", "mokpo", "busan", "jeju"]
    lazy var weatherDataList: [WeatherDTO] = []

    lazy var weatherDataModel: Observable<[WeatherDTO]> = Observable([])
    

    override init() {
        super.init()
        getWeather(countryArr)
    }
}

extension MainViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataModel.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        print("===DataModel: \(weatherDataModel.value[indexPath.row].name)")
        cell.setData(city: weatherDataModel.value[indexPath.row].name,
                     time: Double(weatherDataModel.value[indexPath.row].dt),
                     temp: weatherDataModel.value[indexPath.row].main.temp,
                     temp_min: weatherDataModel.value[indexPath.row].main.tempMin,
                     temp_max: weatherDataModel.value[indexPath.row].main.tempMax,
                     weather: weatherDataModel.value[indexPath.row].weather[0].main)
        return cell
    }
}

extension MainViewModel {
    func getWeather(_ countryArr: [String]) {
        let dispatchGroup = DispatchGroup()

        for i in 0...countryArr.count-1 {
            dispatchGroup.enter()

            let country = countryArr[i]
            WeatherService().getWeather(country: country) { result in
                switch result {
                case .success(let weatherResponse):
                    DispatchQueue.main.async {
                        self.weatherDataList.append(weatherResponse)
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    print("API Error: \(error)")
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.weatherDataModel.value = self.weatherDataList
        }
    }
}

