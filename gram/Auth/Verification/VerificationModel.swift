//
//  VerificationModel.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation

typealias VerifyRequest = Verification.SendCode.Request
typealias VerifyResponse = Verification.SendCode.Response
typealias VerifyViewModel = Verification.SendCode.ViewModel

enum Verification {
    
    enum SendCode {
        struct Request {
            let clientRegisterID: String
            let smsCode: String
        }
        
        struct Response: Codable {
            let success: Bool
            let code: Int
            let message: String
            let result: VerifyResult
            let error: [VerifyError]
        }
        
        struct ViewModel {
            let accessToken: String
            let tokenType: String
            let expiresAt: String
        }
    }
}

struct VerifyResult: Codable {
    let accessToken, tokenType, expiresAt: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresAt = "expires_at"
    }
}

struct VerifyError: Codable {
    let clientRegisterID: [String]

    enum CodingKeys: String, CodingKey {
        case clientRegisterID = "client_register_id"
    }
}
