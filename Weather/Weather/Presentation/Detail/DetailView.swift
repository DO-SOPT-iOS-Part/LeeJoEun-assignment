//
//  DetailView.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

protocol PushMainViewDelegate: AnyObject {
    func listButtonTapped()
}

final class DetailView: UIView {
    weak var delegateList: PushMainViewDelegate?

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.Detail.img_detailBG
        return imageView
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"
        label.font = UIFont.SFPro(size: 36, weight: .regular)
        label.textColor = .WeatherWhite
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "21°"
        label.font = UIFont.SFPro(size: 102, weight: .thin)
        label.textColor = .WeatherWhite
        return label
    }()

    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "흐림"
        label.font = UIFont.SFPro(size: 24, weight: .regular)
        label.textColor = .WeatherWhite
        return label
    }()

    private let maxminLabel: UILabel = {
        let label = UILabel()
        label.text = "최고:28° 최저:11°"
        label.font = UIFont.SFPro(size: 20, weight: .medium)
        label.textColor = .WeatherWhite
        return label
    }()

    private let rectView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 335, height: 212)
        // view.alpha = 0.2
        view.layer.backgroundColor = UIColor.WeatherWhite_03.cgColor
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.WeatherWhite_2.cgColor
        return view
    }()

    private let descriptionTextView: UILabel = {
        let label = UILabel()
        label.text = """
        08:00~09:00에 강우 상태가, 18:00에 한때
        흐린 상태가 예상됩니다.
        """
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.SFPro(size: 18, weight: .regular)
        label.textColor = .WeatherWhite
        return label
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .WeatherWhite
        return view
    }()

    let weatherOfHourCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeatherOfHourCell.self,
                                forCellWithReuseIdentifier: WeatherOfHourCell.identifier)

        return collectionView
    }()

    let weatherOfDayTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(WeatherOfDayTableViewCell.self, forCellReuseIdentifier: WeatherOfDayTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.rowHeight = 55
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = UIColor.WeatherWhite_03.cgColor
        tableView.layer.borderWidth = 2

        return tableView
    }()

    private let bottomNavigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .WeatherDarkBlue

        return view
    }()

    private let dividerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .WeatherWhite
        view.alpha = 0.3

        return view
    }()

    private let mapButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Detail.ic_map, for: .normal)
        button.tintColor = .WeatherWhite

        return button
    }()

    private let paperPlaneButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Detail.ic_paperplane, for: .normal)
        button.tintColor = .WeatherWhite

        return button
    }()

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private let dotButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Detail.ic_dot, for: .normal)
        button.tintColor = .WeatherWhite

        return button
    }()

    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Detail.ic_list, for: .normal)
        button.tintColor = .WeatherWhite
        button.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)

        return button
    }()

    @objc func listButtonTapped() {
        delegateList?.listButtonTapped()
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

extension DetailView {
    func setHierarchy() {
        self.addSubviews(backgroundImageView, scrollView, bottomNavigationView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(cityLabel, temperatureLabel, stateLabel, maxminLabel, rectView, weatherOfDayTableView)
        rectView.addSubviews(descriptionTextView, dividerView, weatherOfHourCollectionView)
        bottomStackView.addArrangedSubviews(paperPlaneButton, dotButton)
        bottomNavigationView.addSubviews(dividerView2, mapButton, bottomStackView, listButton)
    }

    func setConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1250)
        }
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        maxminLabel.snp.makeConstraints {
            $0.top.equalTo(stateLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        rectView.snp.makeConstraints {
            $0.top.equalTo(maxminLabel.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(212)
            $0.centerX.equalToSuperview()
        }
        descriptionTextView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        dividerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(66)
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(0.5)
        }
        weatherOfHourCollectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        weatherOfDayTableView.snp.makeConstraints {
            $0.top.equalTo(rectView.snp.bottom).offset(20)
            $0.height.equalTo(620)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        bottomNavigationView.snp.makeConstraints {
            $0.height.equalTo(78)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        dividerView2.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.top.leading.trailing.equalToSuperview()
        }
        mapButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(4)
        }
        bottomStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.height.equalTo(24)
            $0.centerX.equalToSuperview()
        }
        paperPlaneButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        dotButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        listButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(4)
        }
    }
}

