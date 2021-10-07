//
//  WebService.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import Foundation

struct Constants {
    
    static let creditCheckURL = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"

    /// A structure which keeps web-service request's keys
    struct RequestHeaderKey {
        static let soapHeader_ContentType_Key = "Content-Type"
        static let requestResponseContentType = "application/json"
    }
    
    /// A parameter which returns Application Title
    static var title: String {
        if let infoDict = Bundle.main.infoDictionary, let title = infoDict["CFBundleDisplayName"] as? String {
            return title
        } else {
            return "ClearScore"
        }
    }
}
