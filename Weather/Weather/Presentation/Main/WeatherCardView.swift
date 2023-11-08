//
//  WeatherCardView.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

final class WeatherCardView: UIButton {
    private let weatherCard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Main.img_cardBG
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    private let myPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.font = UIFont.SFPro(size: 24, weight: .bold)
        label.textColor = .WeatherWhite
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherCardView {
    func setHierarchy() {
        addSubview(weatherCard)
        weatherCard.addSubviews(myPlaceLabel, cityLabel, stateLabel, temperatureLabel, maxminLabel)
    }

    func setConstraints() {
        weatherCard.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(117)
        }
        myPlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(myPlaceLabel.snp.bottom).offset(2)
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
