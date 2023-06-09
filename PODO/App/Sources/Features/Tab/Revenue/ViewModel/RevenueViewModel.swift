//
//  RevenueViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/05.
//

import Combine
import UIKit

final class RevenueViewModel {

    var fetchCompletionPublihser: AnyPublisher<Void, Never> {
        self.fetchCompletionSubject.eraseToAnyPublisher()
    }

    init() {
        Task {
            await self.requestAPI()

            await MainActor.run {
                self.fetchCompletionSubject.send(())
            }
        }
    }

    private func requestAPI() async {
        let data = await self.repository.fetchRevenue()
        self.model = RevenueDataModel(data: data ?? .newMock)
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var rows: [RowType] = RowType.allCases
    private var model: RevenueDataModel?

    private let repository = TabRepository()
    private let fetchCompletionSubject = PassthroughSubject<Void, Never>()
}

// MARK: - API Request
extension RevenueViewModel {
}

// MARK: - UI Setting Data
extension RevenueViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        RowType.allCases.map { $0.cellType }
    }

    var totalBalance: Double? {
        self.model?.data.totalBalance
    }

    var articleData: RevenueArticleData? {
        self.model?.data.article
    }

    var answerData: RevenueAnswerData? {
        self.model?.data.answer
    }

    var numberOfRows: Int {  self.rows.count }

    func heightForRow(_ row: Int) -> CGFloat {
        guard let type = self.rows[safe: row] else { return .leastNonzeroMagnitude }
        return type.heightForRow
    }

    func cellTypeForRow(_ row: Int) -> UITableViewCell.Type? {
        guard let type = self.rows[safe: row] else { return nil }
        return type.cellType
    }
}

// MARK: - RowType
extension RevenueViewModel {

    enum RowType: Int, CaseIterable {
        case header
        case article
        case answer
    }
}

private extension RevenueViewModel.RowType {

    var cellType: UITableViewCell.Type {
        switch self {
        case .header:   return RevenueHeaderTableViewCell.self
        case .article:  return RevenueListTableViewCell.self
        case .answer:   return RevenueExpertTableViewCell.self
        }
    }

    var heightForRow: CGFloat {
        switch self {
        case .header:   return 155.0
        case .article:  return 342.0
        case .answer:   return 286.0
        }
    }
}
