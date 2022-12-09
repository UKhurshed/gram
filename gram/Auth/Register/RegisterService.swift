//
//  RegisterService.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import Foundation

struct APIConstants {
    static let scheme: String = "http"
    static let hostURL: String = "testapi.client.gram.tj"
    static let registerPathURL: String = "/api/auth/client-registers"
    /*
     static let appKey: String = "3fbb1a4b2950b471fd44af22fa086b15"
     static let units: String = "metric"
     static let language: String = "ru"
     static let hostURL: String = "api.openweathermap.org"
     static let scheme: String = "http"
     static let pathURL: String = "/data/2.5/forecast"
     static let cnt: String = "40"
     */
}

class RegisterServiceImpl: RegisterService {
    
    let urlSession: UrlSessionProtocol
    
    init(urlSession: UrlSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func registerUserByPhoneNumber(request: RegisterRequest) async throws -> RegisterResponse {
        let params: [String: String] = [
            "phone_number": request.phoneNumber
        ]
        
        let apiRequest = APIRequest(path: APIConstants.registerPathURL, params: params, host: APIConstants.hostURL, httpMethod: .post)
        let response: RegisterResponse = try await urlSession.registerUserByPhoneNumber(with: apiRequest)
        print("RegisterServiceImpl registerUserByPhoneNumber: \(response)")
        return response
    }
    
    
    func registerUser() -> String{
        var text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let random = Int.random(in: 1...20)
            text = "A new User: \(random)"
        }
        return text
    }
    
}
