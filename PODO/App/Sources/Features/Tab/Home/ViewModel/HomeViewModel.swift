//
//  HomeViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/01.
//

import UIKit

final class HomeViewModel {

    init() {
        // api call
        self.model = HomeDataModel()
    }

    func updateSelectedCategory(_ category: Int) {
        self.model?.updateSelectedCategory(category)
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var sections: [SectionType] = SectionType.allCases
    private var model: HomeDataModel?
}

// MARK: UI Setting Data
extension HomeViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        SectionType.allCases.map { $0.cellType }
    }

    static var headerTypes: [UITableViewHeaderFooterView.Type] {
        SectionType.allCases.compactMap { $0.headerViewType }
    }

    var selectedCategory: Int { self.model?.selectedCategory ?? .zero }
    var categories: [String]  { self.model?.categories ?? []          }
    var numberOfSections: Int { self.sections.count                   }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let type = self.sections[safe: section] else { return .zero }

        switch type {
        case .new:      fallthrough
        case .hottest:  return 1
        case .insight:  return self.model?.insightArticles.count ?? .zero
        }
    }

    func heightForRowInSection(_ section: Int) -> CGFloat {
        guard let type = self.sections[safe: section] else { return .leastNonzeroMagnitude }
        return type.heightForRow
    }

    func heightForHeaderInSection(_ section: Int) -> CGFloat {
        guard let type = self.sections[safe: section] else { return .leastNonzeroMagnitude }
        return type.heightForHeader
    }

    func cellTypeForSection(_ section: Int) -> UITableViewCell.Type? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.cellType
    }

    func headerViewTypeForSection(_ section: Int) -> UITableViewHeaderFooterView.Type? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.headerViewType
    }

    func titleForSection(_ section: Int) -> String? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.title
    }

    func dataForSection(_ section: Int) -> [ArticleData] {
        guard let type = self.sections[safe: section] else { return [] }

        switch type {
        case .new:      return self.model?.data?.newArticles ?? []
        case .hottest:  return self.model?.data?.hottestArticles ?? []
        case .insight:  return self.model?.insightArticles ?? []
        }
    }

    func dataForIndexPath(_ indexPath: IndexPath) -> ArticleData? {
        self.dataForSection(indexPath.section)[safe: indexPath.row]
    }

    func canSelectForSection(_ section: Int) -> Bool {
        guard let type = self.sections[safe: section] else { return false }
        return type.canSelectTabelViewCell
    }
}

// MARK: API Request
extension HomeViewModel {
}

extension HomeViewModel {

    enum SectionType: Int, CaseIterable {
        case new
        case hottest
        case insight
    }
}

private extension HomeViewModel.SectionType {

    var title: String {
        switch self {
        case .new:      return "NOW"
        case .hottest:  return "Hottest articles"
        case .insight:  return "Your insight"
        }
    }

    var subtitle: String? {
        switch self {
        case .new:      return "New Articles Here!"
        case .hottest:  fallthrough
        case .insight:  return nil
        }
    }

    var cellType: UITableViewCell.Type {
        switch self {
        case .new:      return HomeNewTableViewCell.self
        case .hottest:  return HomeHottestTableViewCell.self
        case .insight:  return HomeInsightTableViewCell.self
        }
    }

    var headerViewType: UITableViewHeaderFooterView.Type? {
        switch self {
        case .new:      fallthrough
        case .hottest:  return nil
        case .insight:  return HomeInsightTableViewHeaderView.self
        }
    }

    var heightForRow: CGFloat {
        switch self {
        case .new:      return 342.0
        case .hottest:  return 288.0
        case .insight:  return 128.0
        }
    }

    var heightForHeader: CGFloat {
        switch self {
        case .new:      return .leastNonzeroMagnitude
        case .hottest:  return 0.01//.leastNonzeroMagnitude
        case .insight:  return 86.0
        }
    }

    var canSelectTabelViewCell: Bool {
        switch self {
        case .new:      fallthrough
        case .hottest:  return false
        case .insight:  return true
        }
    }
}
