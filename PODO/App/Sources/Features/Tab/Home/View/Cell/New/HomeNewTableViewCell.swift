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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(HomeNewCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }
        if let data = self.articles[safe: indexPath.item] {
            cell.updateData(data)
        }
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension HomeNewTableViewCell: UICollectionViewDelegateFlowLayout {

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

// MARK: - CollectionView Layout
private extension HomeNewTableViewCell {

    struct CollectionViewLayout {

        static let `default` = CollectionViewLayout(insets: .init(top: .zero,
                                                                  left: 28.0,
                                                                  bottom: .zero,
                                                                  right: 28.0),
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
        self.setupSubtitleLabel()
        self.setupAlarmButton()
        self.setupAlarmBadgeView()
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
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(self.alarmButton.snp.leading).offset(34.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 18.0, weight: .bold)
            $0.textColor = .white2
            $0.text = "NOW"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(self.alarmButton.snp.leading).offset(34.0)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .white2
            $0.text = "New Articles Here!"
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
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(18.0)
            $0.bottom.equalToSuperview().inset(38.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: HomeNewCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }
}
