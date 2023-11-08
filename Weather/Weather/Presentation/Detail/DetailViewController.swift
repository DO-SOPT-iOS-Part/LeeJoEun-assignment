//
//  DetailViewController.swift
//  Weather
//
//  Created by 이조은 on 2023/10/25.
//

import UIKit

import SnapKit

final class DetailViewController: UIViewController {
    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.delegateList = self

        setHierarchy()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }

    func setHierarchy() {
        self.view.addSubview(detailView)
    }

    func setConstraints() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DetailViewController: PushMainViewDelegate {
    func listButtonTapped() {
        print("listButtonTapped")
        self.navigationController?.popViewController(animated: true)
    }
}
