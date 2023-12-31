//
//  WeatherOfHourView.swift
//  Weather
//
//  Created by 이조은 on 2023/10/26.
//

import UIKit

import SnapKit

final class WeatherOfHourCell: UICollectionViewCell {
    static let identifier = "WeatherOfHourCell"

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "Now"
        label.font = UIFont.SFPro(size: 17, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.moon.fill")
        imageView.tintColor = .WeatherWhite
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°"
        label.font = UIFont.SFPro(size: 22, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    func setHourData(hour: String, weather: String, temperature: String) {
        self.hourLabel.text = hour
        self.weatherImage.image = UIImage(systemName: weather)
        self.temperatureLabel.text = temperature
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherOfHourCell {
    func setHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubviews(hourLabel, weatherImage, temperatureLabel)
    }

    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.width.equalTo(34)
            $0.height.equalTo(118)
        }
        hourLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        weatherImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(32)
        }
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
}
