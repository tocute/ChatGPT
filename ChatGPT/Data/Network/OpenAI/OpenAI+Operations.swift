//
//  OpenAI+Operations.swift
//  ChatGPTExtension
//
//  Created by Adolfo Vera Blasco on 5/3/23.
//

import Foundation

extension OpenAI {
    func codeSmellsFor(code: String, language: String) async throws -> ChatGPTResponse {
        let smellsPrompt = String(format: "\(localizedPrompt("PROMPT_CODE_SMELLS")) \(code)", language)
        
        return try await processRequestFor(prompt: smellsPrompt)
    }
    
    func analyze(source code: String, language: String) async throws -> ChatGPTResponse {
        if let data = try? JSONEncoder().encode(code) {
            print(data)
        }

        let jsonPrompt = String(format: "\(localizedPrompt("PROMPT_JSON")) \(code)", language)

        return try await processRequestFor(prompt: jsonPrompt)
    }
    
    func explain(source code: String, language: String) async throws -> ChatGPTResponse {
        let explainPrompt = String(format: "\(localizedPrompt("PROMPT_EXPLAIN_CODE")) \(code)", language)

        return try await processRequestFor(prompt: explainPrompt)
    }
    
    func generateTestsFor(source code: String, language: String) async throws -> ChatGPTResponse {
        let testsPrompt = String(format: "\(localizedPrompt("PROMPT_GENERATE_UNIT_TEST")) \(code)", language)

        return try await processRequestFor(prompt: testsPrompt)
    }
    
    func generateRegexFor(string value: String, language: String) async throws -> ChatGPTResponse {
        let regexPrompt = String(format: "\(localizedPrompt("PROMPT_REGEX")) \(value)", language)

        return try await processRequestFor(prompt: regexPrompt)
    }
    
    func comment(function code: String, language: String) async throws -> ChatGPTResponse {
        let commentPrompt = String(format: "\(localizedPrompt("PROMPT_COMMENT")) \(code)", language)

        return try await processRequestFor(prompt: commentPrompt)
    }
    
    func  others(function code: String) async throws -> ChatGPTResponse {
        return try await processRequestFor(prompt: code)
    }
}
