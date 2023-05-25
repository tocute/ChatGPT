//
//  CodeSmellsRepository.swift
//  ChatGPTExtension
//
//  Created by Adolfo Vera Blasco on 4/3/23.
//

import Foundation

protocol CodeSmellsRepository {
    func searchForCodeSmells(in code: String) async throws -> [Suggestion]
}
