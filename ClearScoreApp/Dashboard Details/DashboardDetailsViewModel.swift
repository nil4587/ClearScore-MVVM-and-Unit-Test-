//
//  DashboardDetailsViewModel.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/07.
//

import Foundation

struct DashboardDetailsViewModel {
    
    private var creditScoreReport: CreditReportInfoModel?
    
    init(creditScoreReport: CreditReportInfoModel?) {
        self.creditScoreReport = creditScoreReport
    }
}
