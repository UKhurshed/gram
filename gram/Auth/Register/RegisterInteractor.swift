//
//  RegisterInteractor.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit

protocol RegisterBusinessLogic: AnyObject {
    func sendPhoneNumber(reguest: RegisterRequest) async throws -> RegisterResponse
}

protocol RegisterService {
    func registerUserByPhoneNumber(request: RegisterRequest) async throws -> RegisterResponse
}

class RegisterInteractor: RegisterBusinessLogic {
    let service: RegisterService
    
    init(service: RegisterService) {
        self.service = service
    }

    
    func sendPhoneNumber(reguest: RegisterRequest) async throws -> RegisterResponse {
        print("Request from interactor: \(reguest.phoneNumber)")
    
        let serviceResult: RegisterResponse = try await service.registerUserByPhoneNumber(request: reguest)
        return serviceResult
    }
}

