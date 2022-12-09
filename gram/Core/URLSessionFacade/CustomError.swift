//
//  CustomError.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation

enum CustomError: Error {
    case jsonParseError
    case urlRequestNull
    case nullData
    case urlCallError
    case networkSessionError
    case freedReference
    case serviceWasNil
    case customError
}
