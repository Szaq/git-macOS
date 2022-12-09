//
//  GitLogRecordStats.swift
//  Git-macOS
//
//  Created by Łukasz Kwoska on 08/12/2022.
//

import Foundation

public class  GitLogRecordStats: Codable {
    private(set) public var filesChanged: Int?
    private(set) public var insertions: Int?
    private(set) public var deletions: Int?

    public init(filesChanged: Int? = nil, insertions: Int? = nil, deletions: Int? = nil) {
        self.filesChanged = filesChanged
        self.insertions = insertions
        self.deletions = deletions
    }
}
