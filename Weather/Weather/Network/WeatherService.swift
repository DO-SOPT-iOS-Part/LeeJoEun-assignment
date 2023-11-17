//
//  WeatherService.swift
//  Weather
//
//  Created by 이조은 on 2023/11/17.
//

import Foundation

class WeatherService {
    func getWeather(country: String, completion: @escaping (Result<WeatherDTO, NetworkError>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(country)&appid=5b503e9dd2c45338566211a0c0036ca6")

        guard let url = url else {
            return completion(.failure(.pathErr))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.responseDecodingErr))
            }
            let weatherResponse = try? JSONDecoder().decode(WeatherDTO.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.responseErr))
            }
        }.resume()
    }
}
