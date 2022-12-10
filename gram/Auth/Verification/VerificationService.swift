//
//  VerificationService.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation


class VerificationServiceImpl: VerificationService {
    let urlSession: UrlSessionProtocol
    
    init(urlSession: UrlSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func verifyService(request: VerifyRequest) async throws -> VerifyResponse {
        let params: [String: String] = [
            "client_register_id": request.clientRegisterID,
            "sms_code" : request.smsCode
        ]
        
        let verifyResponse: VerifyResponse = try await urlSession.verifyBySmsCode(with: APIRequest(path: APIConstants.verifyPathURL, params: params, host: APIConstants.hostURL, httpMethod: .post))
        UserDefaults.standard.set(verifyResponse.result.accessToken, forKey: UserDefaultsKeyContants.accessToken)
        return verifyResponse
    }
}
