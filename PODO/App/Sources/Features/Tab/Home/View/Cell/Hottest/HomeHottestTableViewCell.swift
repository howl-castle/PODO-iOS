//
//  HomeHottestTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCell(_ cell: UITableViewCell, didTapItem item: ArticleData, atIndex index: Int)
}

final class HomeHottestTableViewCell: UITableViewCell {

    weak var delegate: HomeTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: [ArticleData]) {
        self.articles = data
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    @objc private func didTapAlarmButton(_ sender: UIButton) {

    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupCollectionView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.collectionView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 18.0, weight: .bold)
            $0.textColor = .white2
            $0.text = "Hottest articles"
        }
    }

    private func setupCollectionView() {
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(18.0)
            $0.bottom.equalToSuperview().inset(32.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: HomeHottestCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }

    private var articles: [ArticleData] = []

    private let titleLabel = UILabel(frame: .zero)
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
}

extension HomeHottestTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(HomeHottestCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }
        if let data = self.articles[safe: indexPath.item] {
            cell.updateData(data)
        }
        return cell
    }
}

extension HomeHottestTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CollectionViewLayout.default.calculateItemWidth(fromWidth: collectionView.bounds.width)
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        CollectionViewLayout.default.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CollectionViewLayout.default.lineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.articles[safe: indexPath.item] else { return }
        self.delegate?.homeTableViewCell(self, didTapItem: item, atIndex: indexPath.item)
    }
}

private extension HomeHottestTableViewCell {

    struct CollectionViewLayout {

        static let `default` = CollectionViewLayout(insets: .init(top: .zero,
                                                                  left: 20.0,
                                                                  bottom: .zero,
                                                                  right: 20.0),
                                                    lineSpacing: 8.0)

        let insets: UIEdgeInsets
        let lineSpacing: CGFloat
    }
}

private extension HomeHottestTableViewCell.CollectionViewLayout {

    func calculateItemWidth(fromWidth width: CGFloat) -> CGFloat {
        let margin = self.insets.left + self.lineSpacing * 2
        let width = (width - margin) / 2.0
        return width
    }
}
