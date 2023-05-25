//
//  ChatGPTCodeSmellsRepository.swift
//  ChatGPTExtension
//
//  Created by Adolfo Vera Blasco on 4/3/23.
//

import Foundation

final class ChatGPTCodeSmellsRepository: BaseChatGPTRepository {
    override func askChatGPTFor(_ apiKey: String?, source code: String, language: String) async throws -> Suggestion {
        guard let apiKey = apiKey else {
            throw ConverterError.authorization
        }
        
        let openAI = OpenAI(key: apiKey)
        
        var suggestions: [Suggestion]?
        
        do {
            let chatpGPTResponse = try await openAI.codeSmellsFor(code: code, language: language)
            
            suggestions = chatpGPTResponse.choices.map { choice in
                let suggestion = Suggestion(result: choice.message.content)
                
                return suggestion
            }
        } catch ChatGPTError.rateLimitReached {
            throw ConverterError.rateLimit
        } catch ChatGPTError.serverError {
            throw ConverterError.serverStatus
        } catch ChatGPTError.authentication {
            throw ConverterError.authorization
        } catch {
            throw ConverterError.unknownResponse
        }
        
        guard let suggestions = suggestions,
              let suggestion = suggestions.first else {
            throw ConverterError.emptyResults
        }
        
        return suggestion
    }
}
