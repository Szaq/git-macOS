//
//  GitNonJsonDecoder.swift
//  Git-macOS
//
//  Created by Łukasz Kwoska on 08/12/2022.
//

import Foundation

protocol GitNonJsonDecoder {
    ///Try parsing non-json line and return any newly created objects or strings that each contains json object. Returns nil if failed
    func tryParse(encodedText: String, lastDecodedObject: Decodable?) -> ([Decodable], [String])?
}
