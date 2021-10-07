//
//  DashboardDetailsViewController.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/07.
//

import Foundation

class DashboardDetailsViewController: BaseViewController {

    var viewModel: DashboardDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createViewModel(with creditReport: CreditReportInfoModel?) {
        self.viewModel = DashboardDetailsViewModel(creditScoreReport: creditReport)
    }
    
}
