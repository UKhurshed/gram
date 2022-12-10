//
//  URLSessionFacade.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation

typealias ResultAPI = (Result<Data, CustomError>) -> Void

protocol UrlSessionProtocol {
    func registerUserByPhoneNumber<RegisterResponse: Decodable>(with apiRequest: APIRequest) async throws -> RegisterResponse
    
    func verifyBySmsCode<VerifyResponse: Decodable>(with apiRequest: APIRequest) async throws -> VerifyResponse
}

class URLSessionFacade: UrlSessionProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func registerUserByPhoneNumber<RegisterResponse: Decodable>(with apiRequest: APIRequest) async throws -> RegisterResponse {
        let urlRequest = try apiRequest.getURLRequest()
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw CustomError.nullData
        }
        print("registerUserByPhoneNumber statusCode: \(httpURLResponse.statusCode)")
        
        return try JSONDecoder().decode(RegisterResponse.self, from: data)
    }
    
    func verifyBySmsCode<VerifyResponse: Decodable>(with apiRequest: APIRequest) async throws -> VerifyResponse {
        let urlRequest = try apiRequest.getURLRequest()
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw CustomError.nullData
        }
        print("verifyBySmsCode statusCode: \(httpURLResponse.statusCode)")
        
        return try JSONDecoder().decode(VerifyResponse.self, from: data)
    }
    
}
