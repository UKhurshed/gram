//
//  RegisterService.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import Foundation


class RegisterService {
    
    func registerUser() -> String{
        var text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let random = Int.random(in: 1...20)
            text = "A new User: \(random)"
        }
        return text
    }
    
}
