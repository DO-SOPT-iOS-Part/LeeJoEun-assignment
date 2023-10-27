//
//  MainView.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

protocol ClickCardViewDelegate: AnyObject {
    func weatherCardTapped()
}

final class MainView: UIView {
    weak var delegateClick: ClickCardViewDelegate?

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Main.ic_more, for: .normal)
        button.tintColor = .WeatherWhite
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "날씨"
        label.font = UIFont.SFPro(size: 36, weight: .bold)
        label.textColor = .WeatherWhite
        return label
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.font = UIFont.SFPro(size: 19, weight: .regular)
        searchBar.searchTextField.backgroundColor = .WeatherWhite_1
        searchBar.searchTextField.textColor = .WeatherWhite_5
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "도시 또는 공항 검색", attributes: [NSAttributedString.Key.foregroundColor : UIColor.WeatherWhite_5])
        searchBar.searchTextField.leftView?.tintColor = .WeatherWhite_5
        searchBar.layer.cornerRadius = 10
        return searchBar
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let weatherCard1: WeatherCardView = {
        let view = WeatherCardView()
        view.addTarget(self, action: #selector(clickWeatherCard), for: .touchUpInside)
        return view
    }()

//    private func addWeatherCard() {
//        (0..<7).map { idx in
//            let WeatherCard: WeatherCardView = {
//                let weatherCard = WeatherCardView()
//                return weatherCard
//            }()
//            return WeatherCard
//        }
//        .forEach(stackView.addArrangedSubview)
//    }

    @objc func clickWeatherCard(sender: UITapGestureRecognizer) {
        delegateClick?.weatherCardTapped()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setHierarchy()
        setConstraints()

        //addWeatherCard()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHierarchy() {
        addSubviews(moreButton, titleLabel, searchBar)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(weatherCard1)
    }

    func setConstraints() {
        moreButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.top.equalToSuperview().inset(56)
            $0.trailing.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(moreButton.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(24)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.width.equalTo(335)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            // $0.width.equalTo(335)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
