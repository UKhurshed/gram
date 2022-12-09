//
//  RegisterModel.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit

typealias RegisterRequest = Register.SendPhoneNumber.Request
typealias RegisterResponse = Register.SendPhoneNumber.Response
typealias RegisterViewModel = Register.SendPhoneNumber.ViewModel

enum Register {
    
    enum SendPhoneNumber {
        
        struct Request {
            let phoneNumber: String
        }
        
        struct Response: Codable {
            let success: Bool
            let code: Int
            let message: String
            let result: ResultResponse
            let error: [ErrorResponse]
        }
        
        struct ViewModel {
            let smsCode: String
            let clientRegisterID: String
        }
    }
}

struct ResultResponse: Codable {
    let smsCode, clientRegisterID: String

    enum CodingKeys: String, CodingKey {
        case smsCode = "sms_code"
        case clientRegisterID = "client_register_id"
    }
}

struct ErrorResponse: Codable {
    let phoneNumber: [String]

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
    }
}
