//
//  RevenueViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/05.
//

import UIKit

final class RevenueViewModel {

    init() {
        // api call
        self.model = RevenueDataModel()
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var rows: [RowType] = RowType.allCases
    private var model: RevenueDataModel?
}

// MARK: UI Setting Data
extension RevenueViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        RowType.allCases.map { $0.cellType }
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

    func dataForRow(_ row: Int) -> Any? {
        guard let type = self.rows[safe: row] else { return nil }
        return nil
    }
}

// MARK: API Request
extension RevenueViewModel {
}

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
        case .header:   return 185.0
        case .article:  return 342.0
        case .answer:   return 286.0
        }
    }
}

struct RevenueDataModel {
    // 엔티티를 그냥 들고 있을 지, 아니면 한번 감싸서 들고 있을 지..
    private(set) var data: RevenueData?

    init() {
    }
}

struct RevenueData: Decodable {
}
