//
//  RegisterInteractor.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation

protocol VerifyBusinessLogic: AnyObject {
    func verifyByCode(request: VerifyRequest) async throws -> VerifyResponse
}

protocol VerificationService {
    func verifyService(request: VerifyRequest) async throws -> VerifyResponse
}


class VerificationInteractor: VerifyBusinessLogic {
    let service: VerificationService
    
    init(service: VerificationService) {
        self.service = service
    }
    
    func verifyByCode(request: VerifyRequest) async throws -> VerifyResponse {
        let verifyResponse = try await service.verifyService(request: request)
        
        return verifyResponse
    }
}
