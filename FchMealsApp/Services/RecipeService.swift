//
//  RecipeService.swift
//  FchMealsApp
//
//  Created by Aadi Shiv Malhotra on 2/7/25.
//

import Foundation

/// Handles fetching recipes from the API.
class RecipeService {
    static let shared = RecipeService()
    
    /// Encode baseURL, but in future, maybe make it a parameter, to allow for easy swap-ability
    private let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    /// Fetches recipes asynchronously.
    func fetchRecipes() async throws -> [Recipe] {
        do {
            let (data, response) = try await URLSession.shared.data(from: baseURL)
            
            // Ensure HTTP response is valid
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            // Decode JSON
            let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            throw error
        }
    }
}
