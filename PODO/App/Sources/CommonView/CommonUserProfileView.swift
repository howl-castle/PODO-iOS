//
//  CommonUserProfileView.swift
//  PODO
//
//  Created by Yun on 2023/03/15.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class CommonUserProfileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareForReuse() {
        self.imageView.kf.cancelDownloadTask()
    }

    func update(imagePath: String?, name: String?, backgroundColor: UIColor? = .orange) {
        self.imageView.image = UIImage(named: "\(imagePath ?? "")")
        return
        if let imagePath = imagePath {
            self.imageView.kf.setImage(with: URL(string: imagePath))
        } else {
            if let initial = name?.first {
                self.nameLabel.text = String(initial)
            }
        }
        self.backgroundColor = backgroundColor
    }

    private let imageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension CommonUserProfileView {

    private func setupUI() {
        self.setupViewHierarchy()
        self.setupImageView()
        self.setupNameLabel()
    }

    private func setupProperties() {
        self.do {
            $0.clipsToBounds = true
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.imageView)
            $0.addSubview(self.nameLabel)
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.imageView.do {
            $0.contentMode = .scaleAspectFill
        }
    }

    private func setupNameLabel() {
        self.nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.nameLabel.do {
            $0.textAlignment = .center
            $0.textColor = .white1
        }
    }
}
