//
//  CreditScoreResponseModel.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import Foundation

struct CreditScoreResponseModel: Decodable {
    var accountIDVStatus: String?
    var creditReportInfo: CreditReportInfoModel?
    var dashboardStatus: String?
    var personaType: String?
    var coachingSummary: CoachingSummaryModel?
    var augmentedCreditScore: Int?
}

extension CreditScoreResponseModel {
    static func returnModelUsing(_ data: Data) -> CreditScoreResponseModel? {
        do {
            let creditScoreResponse = try JSONDecoder().decode(CreditScoreResponseModel.self, from: data)
            return creditScoreResponse
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            return nil
        }
    }
}

struct CreditReportInfoModel: Decodable {
    var score: Int
    var scoreBand: Int
    var clientRef: String?
    var status: String?
    var maxScoreValue: Int
    var minScoreValue: Int
    var monthsSinceLastDefaulted: Int
    var hasEverDefaulted: Bool
    var monthsSinceLastDelinquent: Int
    var hasEverBeenDelinquent: Bool
    var percentageCreditUsed: Int
    var percentageCreditUsedDirectionFlag: Int
    var changedScore: Int
    var currentShortTermDebt: Int
    var currentShortTermNonPromotionalDebt: Int
    var currentShortTermCreditLimit: Int
    var currentShortTermCreditUtilisation: Int
    var changeInShortTermDebt: Int
    var currentLongTermDebt: Int
    var currentLongTermNonPromotionalDebt: Int
    var currentLongTermCreditLimit: Int?
    var currentLongTermCreditUtilisation: Int?
    var changeInLongTermDebt: Int
    var numPositiveScoreFactors: Int
    var numNegativeScoreFactors: Int
    var equifaxScoreBand: Int
    var equifaxScoreBandDescription: String?
    var daysUntilNextReport: Int
}

struct CoachingSummaryModel: Decodable {
    var activeTodo: Bool
    var activeChat: Bool
    var numberOfTodoItems: Int
    var numberOfCompletedTodoItems: Int
    var selected: Bool
}
