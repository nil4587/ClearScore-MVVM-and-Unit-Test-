//
//  WebServiceManager.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebServiceManager: NSObject {
    
    // A singleton
    static let shared = WebServiceManager()
    let sessionConfig = URLSessionConfiguration.ephemeral
    let session: URLSession!
    
    override init() {
        session = URLSession(configuration: sessionConfig)
    }
    
    // A method to handle multiple web-service calls
    func fetchData<T>(resource: Resource<T>,
                      completionHandler: @escaping (_ status: Bool, _ error: String?, _ object: T?) -> Void) {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = [Constants.RequestHeaderKey.soapHeader_ContentType_Key: Constants.RequestHeaderKey.requestResponseContentType]
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as? HTTPURLResponse
            if httpresponse?.statusCode == 200,
               let respondata = data {
                completionHandler(true, nil, resource.parse(respondata))
            } else {
                if let errr = error {
                    completionHandler(false, errr.localizedDescription, nil)
                } else if let statuscode = httpresponse?.statusCode {
                    let message = HTTPURLResponse.localizedString(forStatusCode: statuscode)
                    completionHandler(false, message, nil)
                } else {
                    completionHandler(false, "api_something_went_wrong".localised(), nil)
                }
            }
        }
        task.resume()
    }
}

// MARK: - ================================
// MARK: URLSession Delegate Methods
// MARK: ================================

extension WebServiceManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}
