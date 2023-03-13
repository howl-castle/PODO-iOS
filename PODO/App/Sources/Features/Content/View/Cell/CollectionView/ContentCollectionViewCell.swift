//
//  ContentCollectionViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class ContentCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.kf.cancelDownloadTask()
    }

    func updateImage(path: String) {
        self.imageView.kf.setImage(with: URL(string: path))
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupImageView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.addSubview(self.imageView)
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.imageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }

    private let imageView = UIImageView(frame: .zero)
}
