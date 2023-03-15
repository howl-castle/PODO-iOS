//
//  HomeNewTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class HomeNewTableViewCell: UITableViewCell {

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

    private var articles: [ArticleData] = []

    private let titleLabel = UILabel(frame: .zero)
    private let titleBadgeView = UIView(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let badgeView = UIView(frame: .zero)
    private let badgeCountLabel = UILabel(frame: .zero)
    private let alarmButton = UIButton(frame: .zero)
    private let alarmBadgeView = UIView(frame: .zero)
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
}

// MARK: - CollectionView DataSource
extension HomeNewTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == .zero {
            return 1
        } else if section == 1 {
            return self.articles.count
        } else {
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.makeCollectionViewCell(collectionView: collectionView, cellForItemAt: indexPath) else { return UICollectionViewCell(frame: .zero) }
        return cell
    }

    private func makeCollectionViewCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        if indexPath.section == .zero {
            let cell = collectionView.dequeueReusableCell(HomeNewNoticeCollectionViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(HomeNewCollectionViewCell.self, for: indexPath)
            if let data = self.articles[safe: indexPath.item] {
                cell?.updateData(data)
            }
            return cell
        } else {
            return UICollectionViewCell(frame: .zero)
        }
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension HomeNewTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CollectionViewLayout.default.calculateItemWidth(fromWidth: collectionView.bounds.width)
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: 4.0, bottom: .zero, right: 4.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CollectionViewLayout.default.lineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.articles[safe: indexPath.item] else { return }
        self.delegate?.homeTableViewCell(self, didTapItem: item, atIndex: indexPath.item)
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

        let x = CGFloat(index) * width - CollectionViewLayout.default.insets.left
        targetContentOffset.pointee = CGPoint(x: x, y: 0)
    }
}

// MARK: - CollectionView Layout
private extension HomeNewTableViewCell {

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

private extension HomeNewTableViewCell.CollectionViewLayout {

    func calculateItemWidth(fromWidth width: CGFloat) -> CGFloat {
        let margin = self.insets.left * 2
        let width = width - margin
        return width
    }
}

// MARK: - Setup
extension HomeNewTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupTitleBadgeView()
        self.setupSubtitleLabel()
        //self.setupAlarmButton()
        //self.setupAlarmBadgeView()
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
            $0.addSubview(self.titleBadgeView)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.collectionView)
            $0.addSubview(self.alarmButton)
        }
        self.alarmButton.addSubview(self.alarmBadgeView)
        //self.contentView.addSubview(self.badgeView)
        //self.badgeView.addSubview(self.badgeCountLabel)
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().inset(20.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 20.0, weight: .bold)
            $0.textColor = .white2
            $0.text = "NOW"
        }
    }

    private func setupTitleBadgeView() {
        let height: CGFloat = 6.0
        self.titleBadgeView.snp.makeConstraints {
            $0.size.equalTo(height)
            $0.top.equalTo(self.titleLabel.snp.top).offset(1.0)
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(6.0)
        }

        self.titleBadgeView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .red
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .gray1
            $0.text = "Here are new articles by your Author!"
        }
    }

    private func setupAlarmButton() {
        self.alarmButton.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.alarmButton.do {
            $0.setImage(UIImage(named: "alarm"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapAlarmButton), for: .touchUpInside)
        }
    }

    private func setupAlarmBadgeView() {
        let height: CGFloat = 6.0
        self.alarmBadgeView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.top.trailing.equalToSuperview()
        }

        self.alarmBadgeView.do {
            //$0.isHidden = true
            $0.backgroundColor = .white1
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupCollectionView() {
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(24.0)
            $0.bottom.equalToSuperview().inset(28.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.contentInset = CollectionViewLayout.default.insets
            $0.showsHorizontalScrollIndicator = false
            $0.decelerationRate = .fast
            $0.isPagingEnabled = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: HomeNewCollectionViewCell.self)
            $0.register(cell: HomeNewNoticeCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }
}
