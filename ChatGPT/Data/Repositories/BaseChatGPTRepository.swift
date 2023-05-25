//
//  BaseChatGPTRepository.swift
//  ChatGPTExtension
//
//  Created by Adolfo Vera Blasco on 4/3/23.
//

import Foundation

class BaseChatGPTRepository {
    func askChatGPTFor(_ ApiKey: String?, source code: String, language: String) async throws -> Suggestion {
        return Suggestion(result: "")
    }
    
    func fetchApiKey() -> String? {
        let currentBundle = Bundle(for: Self.self)
        
        guard let apiKeyURL = currentBundle.url(forResource: "openai", withExtension: "environment"),
              var apiKey = try? String(contentsOf: apiKeyURL, encoding: .utf8)
        else
        {
            return nil
        }
        
        apiKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return apiKey
    }
}
