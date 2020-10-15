//
//  NetworkError.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//
import UIKit

enum NetworkError: Error {
    case badURL
    case badData
    case badImage
    case decodeFailure
    case err(String)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Bad URL, could not convert string to URL", comment: "Bad URL")
        case . badData:
            return NSLocalizedString("Bad data, the data was corrupted or incorrect", comment: "Bad data")
        case .badImage:
            return NSLocalizedString("Bad image, could not convert data to image", comment:"Bad image" )
        case .decodeFailure:
            return NSLocalizedString("Decoding Failure, the data could not be decoded to the model", comment: "Decode Failure")
        case .err(let message):
            return NSLocalizedString(message, comment: "API Error")
        }
    }
}


