//
//  RecipeViewModel.swift
//  FchMealsApp
//
//  Created by Aadi Shiv Malhotra on 2/7/25.
//

import Foundation
import SwiftUI

/// ViewModel responsible for fetching and managing recipes.
@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadRecipes() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedRecipes = try await RecipeService.shared.fetchRecipes()
            self.recipes = fetchedRecipes
        } catch {
            self.errorMessage = "Failed to load recipes. Please try again."
        }

        isLoading = false
    }
}
