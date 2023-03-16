//
//  ExpertTrendingTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ExpertTrendingTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: [QuestionData]) {
        self.questions = data
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    @objc private func didTapWriteButton(_ sender: UIButton) {

    }

    private var questions: [QuestionData] = []

    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
}

// MARK: - CollectionView DataSource
extension ExpertTrendingTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.questions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(ExperTrendingCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }
        if let data = self.questions[safe: indexPath.item] {
            cell.updateData(data)
        }
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ExpertTrendingTableViewCell: UICollectionViewDelegateFlowLayout {

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

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = CollectionViewLayout.default.calculateItemWidth(fromWidth: self.collectionView.bounds.width) + CollectionViewLayout.default.lineSpacing

        let estimatedIndex = scrollView.contentOffset.x / width
        let index: Int

        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }

        let x = CGFloat(index) * width
        targetContentOffset.pointee = CGPoint(x: x, y: 0)
    }
}

// MARK: - CollectionView Layout
private extension ExpertTrendingTableViewCell {

    struct CollectionViewLayout {

        static let `default` = CollectionViewLayout(insets: .init(top: .zero,
                                                                  left: 20.0,
                                                                  bottom: .zero,
                                                                  right: 20.0),
                                                    lineSpacing: 10.0)

        let insets: UIEdgeInsets
        let lineSpacing: CGFloat
    }
}

private extension ExpertTrendingTableViewCell.CollectionViewLayout {

    func calculateItemWidth(fromWidth width: CGFloat) -> CGFloat {
        let margin = self.insets.left * 2
        let width = width - margin
        return width
    }
}

// MARK: - Setup
extension ExpertTrendingTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupCollectionView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.collectionView)
        }
    }

    private func setupCollectionView() {
        self.collectionView.snp.makeConstraints {
            $0.height.equalTo(158.0)
            $0.top.equalToSuperview().inset(18.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = false
            $0.decelerationRate = .fast
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: ExperTrendingCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }
}
