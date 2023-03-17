//
//  TabRepository.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import Foundation

final class TabRepository {

    func fetchHome() async -> HomeData? {
        let result: Result<HomeData, Error> = await self.network.request(api: TabAPI.home)

        switch result {
        case let .success(data):
            return data
        case let .failure(failure):
            ToastManager.showToast(type: .error(failure))
            return nil
        }
    }

    func fetchExpert() async -> ExpertData? {
        let result: Result<ExpertData, Error> = await self.network.request(api: TabAPI.expert)

        switch result {
        case let .success(data):
            return data
        case let .failure(failure):
            ToastManager.showToast(type: .error(failure))
            return nil
        }
    }

    func fetchRevenue() async -> RevenueData? {
        let result: Result<RevenueData, Error> = await self.network.request(api: TabAPI.revenue)

        switch result {
        case let .success(data):
            return data
        case let .failure(failure):
            ToastManager.showToast(type: .error(failure))
            return nil
        }
    }

    func fetchSetting() async -> SettingData? {
        let result: Result<SettingData, Error> = await self.network.request(api: TabAPI.home)

        switch result {
        case let .success(data):
            return data
        case let .failure(failure):
            ToastManager.showToast(type: .error(failure))
            return nil
        }
    }

    private let network = Network()
}
