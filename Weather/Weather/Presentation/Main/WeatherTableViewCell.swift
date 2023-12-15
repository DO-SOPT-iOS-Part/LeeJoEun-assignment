//
//  WeatherCardView.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

final class WeatherTableViewCell: UITableViewCell {
    static let identifier = "WeatherTableViewCell"
    
    private let weatherCard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Main.img_cardBG
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.font = UIFont.SFPro(size: 24, weight: .bold)
        label.textColor = .WeatherWhite
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.SFPro(size: 17, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "흐림"
        label.font = UIFont.SFPro(size: 16, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°"
        label.font = UIFont.SFPro(size: 52, weight: .light)
        label.textColor = .WeatherWhite
        return label
    }()
    
    private let maxminLabel: UILabel = {
        let label = UILabel()
        label.text = "최고:28° 최저:11°"
        label.font = UIFont.SFPro(size: 15, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    func translateToKR(_ word: String) -> String {
        let translationMap: [String: String] = [
            "Seoul": "서울",
            "Mokpo": "목포",
            "Busan": "부산",
            "Jeju City": "제주도",
            "Gunsan": "군산",
            "Rain": "비",
            "Clouds": "흐림",
            "Clear": "맑음",
            "Snow": "눈",
            "Mist": "안개"
        ]
        return translationMap[word] ?? word
    }

    func formatTimestamp(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    func convertToCelsius(_ fahrenheit: Double) -> Int {
        return Int(fahrenheit - 273.15)
    }
    
    func setData(city: String, time: Double, temp: Double, temp_min: Double, temp_max: Double, weather: String) {
        self.cityLabel.text = translateToKR(city)
        self.timeLabel.text = formatTimestamp(time)
        self.temperatureLabel.text = "\(convertToCelsius(temp))°"
        self.maxminLabel.text = "최고:\(convertToCelsius(temp_min))° 최저:\(convertToCelsius(temp_max))°"
        self.stateLabel.text = translateToKR(weather)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setHierarchy()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherTableViewCell {
    func setHierarchy() {
        addSubview(weatherCard)
        weatherCard.addSubviews(cityLabel, timeLabel, stateLabel, temperatureLabel, maxminLabel)
    }
    
    func setConstraints() {
        weatherCard.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(117)
        }
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
        }
        stateLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(16)
        }
        maxminLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
