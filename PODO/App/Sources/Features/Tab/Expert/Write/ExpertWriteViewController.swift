//
//  ExpertWriteViewController.swift
//  PODO
//
//  Created by Yun on 2023/03/14.
//

import UIKit
import SnapKit
import Then

final class ExpertWriteViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @objc private func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    private var navigationView: UIView?
    private var titleLabel: UILabel?
    private var closeButton: UIButton?
    private var confirmButton: UIButton?
}

// MARK: - Setup
extension ExpertWriteViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupNavigationView()
        self.setupCloseButton()
        self.setupConfirmButton()
        self.setupTitleLabel()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        let navigationView = UIView(frame: .zero)
        self.navigationView = navigationView
        self.view.addSubview(navigationView)

        let titleLabel = UILabel(frame: .zero)
        self.titleLabel = titleLabel
        self.navigationView?.addSubview(titleLabel)

        let closeButton = UIButton(frame: .zero)
        self.closeButton = closeButton
        self.navigationView?.addSubview(closeButton)

        let confirmButton = UIButton(frame: .zero)
        self.confirmButton = confirmButton
        self.navigationView?.addSubview(confirmButton)
    }

    private func setupNavigationView() {
        self.navigationView?.snp.makeConstraints {
            $0.height.equalTo(44.0)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupCloseButton() {
        guard let closeButton = self.closeButton else { return }

        closeButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(closeButton.snp.height).multipliedBy(1.0)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
        }

        closeButton.do {
            $0.setImage(UIImage(named: "close"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        }
    }

    private func setupConfirmButton() {
        guard let confirmButton = self.confirmButton else { return }

        confirmButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(confirmButton.snp.height).multipliedBy(1.0)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }

        confirmButton.do {
            $0.setImage(UIImage(named: "check"), for: .normal)
            $0.imageView?.updateImageTintColor(.white1)
            $0.addTarget(self, action: #selector(self.didTapConfirmButton), for: .touchUpInside)
        }
    }

    private func setupTitleLabel() {
        guard let closeButton = self.closeButton     else { return }
        guard let confirmButton = self.confirmButton else { return }

        self.titleLabel?.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(closeButton.snp.trailing).offset(16.0)
            $0.trailing.greaterThanOrEqualTo(confirmButton.snp.leading).offset(-16.0)
        }

        self.titleLabel?.do {
            $0.numberOfLines = 1
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white2
            $0.text = "Writing a question"
        }
    }
}
