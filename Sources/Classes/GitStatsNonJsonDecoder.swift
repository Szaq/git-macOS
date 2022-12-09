//
//  GitStatsNonJsonDecoder.swift
//  Git-macOS
//
//  Created by Łukasz Kwoska on 08/12/2022.
//

import Foundation

struct StatsGitNonJsonDecoder: GitNonJsonDecoder {
    func tryParse(encodedText: String, lastDecodedObject: Decodable?) -> ([Decodable], [String])? {
        guard let regex = try? NSRegularExpression(pattern: "((\\d+) files? changed)?,? ?((\\d+) insertions?\\(\\+\\))?,? ?((\\d+) deletions?\\(\\-\\))?(\\\\n(.+))?") else { return nil }

        let results = regex.matches(in: encodedText, range: NSRange(encodedText.startIndex..., in: encodedText))
        guard results.count > 0,
              results[0].numberOfRanges == 9
        else  { return nil }


        let stats = GitLogRecordStats(
            filesChanged: matchedString(atIndex: 2, result: results[0], in: encodedText).flatMap { Int($0)},
            insertions: matchedString(atIndex: 4, result: results[0], in: encodedText).flatMap { Int($0)},
            deletions: matchedString(atIndex: 6, result: results[0], in: encodedText).flatMap { Int($0)})

        (lastDecodedObject as? GitLogRecord)?.stats = stats

        let rest = matchedString(atIndex: 8, result: results[0], in: encodedText)
        return ([], rest.map { [$0] } ?? [])
    }

    private func matchedString(atIndex index: Int, result: NSTextCheckingResult, in string: String) -> String? {
        guard index < result.numberOfRanges else { return nil }
        let range = result.range(at: index)
        guard range.location != NSNotFound else { return nil }
        return String(string[Range(range, in: string)!])
    }
}
