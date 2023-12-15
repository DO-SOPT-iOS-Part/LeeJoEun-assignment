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
    var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true

        mainView.weatherTableView.delegate = self

        setHierarchy()
        setConstraints()
        self.bindViewModel()
    }

    func setHierarchy() {
        self.view.addSubview(mainView)
    }

    func setConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bindViewModel() {
        // 뷰컨트롤러에 있는 tableview의 dataSource를 뷰 모델로 설정 !!
        mainView.weatherTableView.dataSource = viewModel
        self.viewModel.weatherDataModel.bind { [weak self] _ in
            guard let self else {return}
            mainView.weatherTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index: Int = indexPath.row
        let nextVC = DetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
