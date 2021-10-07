//
//  DashboardViewModel.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import Foundation

protocol DashboardViewModelDelegate: NSObjectProtocol {
    func creditScoreSuccess()
    func creditScoreFailure(with errorMessage: String)
}

class DashboardViewModel {
    
    private weak var delegate: DashboardViewModelDelegate?
    private var creditScoreResponse: CreditScoreResponseModel?
    
    init(delegate: DashboardViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - ================================
    // MARK: Getters
    // MARK: ================================
    
    var dashboardStatus: String {
        return self.creditScoreResponse?.dashboardStatus ?? ""
    }
    
    var totalScore: Int {
        return self.creditScoreResponse?.creditReportInfo?.maxScoreValue ?? 0
    }
    
    var score: Int {
        return self.creditScoreResponse?.creditReportInfo?.score ?? 0
    }
    
    var isScoreAvailable: Bool {
        return self.creditScoreResponse != nil
    }
    
    var creditReportModel: CreditReportInfoModel? {
        return creditScoreResponse?.creditReportInfo
    }
    
    // MARK: - ================================
    // MARK: User-defined method
    // MARK: ================================
    
    func resetCreditScoreData() {
        self.creditScoreResponse = nil
    }
    
    // MARK: - ================================
    // MARK: Web-service
    // MARK: ================================
    
    func fetchCreditScoreData(using url: URL?) {
        
        guard let requestURL = url else {
            self.delegate?.creditScoreFailure(with: "invalid_url".localised())
            return
        }
        
        let resource = Resource<CreditScoreResponseModel>(url: requestURL) { data in
            return CreditScoreResponseModel.returnModelUsing(data)
        }
        
        WebServiceManager.shared.fetchData(resource: resource){[weak self] (status, errorMessage, response) in
            if status == true && response != nil {
                self?.creditScoreResponse = response
                self?.delegate?.creditScoreSuccess()
            } else {
                #if DEBUG
                print(errorMessage as Any)
                #endif
                self?.delegate?.creditScoreFailure(with: errorMessage!)
            }
        }
    }
}
