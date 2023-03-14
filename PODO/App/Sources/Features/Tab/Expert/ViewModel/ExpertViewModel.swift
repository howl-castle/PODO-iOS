//
//  ExpertViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/05.
//

import UIKit

final class ExpertViewModel {

    init() {
        // api call
        self.model = ExpertDataModel()
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var sections: [SectionType] = SectionType.allCases
    private var model: ExpertDataModel?
}

// MARK: - API Request
extension ExpertViewModel {
}

// MARK: - UI Setting Data
extension ExpertViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        SectionType.allCases.map { $0.cellType }
    }

    static var headerTypes: [UITableViewHeaderFooterView.Type] {
        SectionType.allCases.compactMap { $0.headerViewType }
    }

    var numberOfSections: Int { self.sections.count }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let type = self.sections[safe: section] else { return .zero }

        switch type {
        case .trending:     return 1    // 갯수 체크
        case .recommend:    return self.model?.data?.recommendQuestion?.count ?? .zero
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

    func dataForSection(_ section: Int) -> [QuestionData] {
        guard let type = self.sections[safe: section] else { return [] }

        switch type {
        case .trending:
            return [self.model?.data?.myQuestion,
                    self.model?.data?.trendingQuestion]
                .compactMap { $0 }
                .flatMap { $0 }
        case .recommend:
            return self.model?.data?.recommendQuestion ?? []
        }
    }

    func dataForIndexPath(_ indexPath: IndexPath) -> QuestionData? {
        self.dataForSection(indexPath.section)[safe: indexPath.row]
    }
}

// MARK: - SectionType
extension ExpertViewModel {

    enum SectionType: Int, CaseIterable {
        case trending   // 내가 질문한 질문 + 트랜딩
        case recommend
    }
}

private extension ExpertViewModel.SectionType {

    var title: String {
        switch self {
        case .trending:     return "Expert"
        case .recommend:    return "I think you can answer!"
        }
    }

    var subtitle: String? {
        switch self {
        case .trending:     return "Check out the new answer!"
        case .recommend:    return "Answer the Question to receive DORA"
        }
    }

    var cellType: UITableViewCell.Type {
        switch self {
        case .trending:     return ExpertTrendingTableViewCell.self
        case .recommend:    return ExpertRecommendTableViewCell.self
        }
    }

    var headerViewType: UITableViewHeaderFooterView.Type? {
        switch self {
        case .trending:     return nil
        case .recommend:    return ExpertRecommendTableViewHeaderView.self
        }
    }


    var heightForRow: CGFloat {
        switch self {
        case .trending:     return 291.0
        case .recommend:    return 184.0
        }
    }

    var heightForHeader: CGFloat {
        switch self {
        case .trending:     return .leastNonzeroMagnitude
        case .recommend:    return 95.0
        }
    }
}
