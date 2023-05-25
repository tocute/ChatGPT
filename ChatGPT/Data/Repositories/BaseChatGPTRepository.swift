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
    
}
