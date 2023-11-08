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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        mainView.delegateClick = self

        setHierarchy()
        setConstraints()
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

extension MainViewController: ClickCardViewDelegate {
    func weatherCardTapped() {
        let nextVC = DetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
