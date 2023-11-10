//
//  WeatherOfDayTableViewCell.swift
//  Weather
//
//  Created by 이조은 on 2023/11/09.
//

import UIKit

import SnapKit

final class WeatherOfDayTableViewCell: UITableViewCell {
    static let identifier = "WeatherOfDayTableViewCell"

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = UIFont.SFPro(size: 22, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.tintColor = .WeatherYellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let minLabel: UILabel = {
        let label = UILabel()
        label.text = "16°"
        label.font = UIFont.SFPro(size: 22, weight: .medium)
        label.textColor = .WeatherWhite_2
        return label
    }()

    private let temparatureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Detail.img_temparatureBar1
        return imageView
    }()

    private let maxLabel: UILabel = {
        let label = UILabel()
        label.text = "23°"
        label.font = UIFont.SFPro(size: 22, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    func setDayData(day: String, weather: String, min: String, temperatureImage: UIImage, max: String) {
        self.dayLabel.text = day
        self.weatherImage.image = UIImage(systemName: weather)
        self.minLabel.text = min
        self.temparatureImage.image = temperatureImage
        self.maxLabel.text = max
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

extension WeatherOfDayTableViewCell {
    func setHierarchy() {
        self.addSubviews(dayLabel, weatherImage, minLabel, temparatureImage, maxLabel)
    }

    func setConstraints() {
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(278)
        }
        weatherImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(87)
            $0.height.equalTo(28)
        }
        minLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(weatherImage.snp.trailing).offset(16)
            $0.height.equalTo(26)
        }
        temparatureImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(minLabel.snp.trailing).offset(10)
            $0.width.equalTo(102)
        }
        maxLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(temparatureImage.snp.trailing).offset(9)
            $0.height.equalTo(26)
        }
    }
}
