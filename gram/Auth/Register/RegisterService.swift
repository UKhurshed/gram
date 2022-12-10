//
//  RegisterService.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import Foundation

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
        UserDefaults.standard.set(response.result.clientRegisterID, forKey: "clientRegisterID")
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
