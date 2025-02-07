//
//  RecipeListView.swift
//  FchMealsApp
//
//  Created by Aadi Shiv Malhotra on 2/7/25.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    @State private var searchText = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            viewModel.recipes
        } else {
            viewModel.recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading recipes...")
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        Task {
                            await viewModel.loadRecipes()
                        }
                    }
                } else if filteredRecipes.isEmpty {
                    EmptyStateView()
                } else {
                    List(filteredRecipes) { recipe in
                        RecipeRowView(recipe: recipe)
                            .transition(.opacity.combined(with: .move(edge: .trailing)))
                    }
                    .animation(.easeInOut(duration: 0.3), value: filteredRecipes)
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
            .searchable(text: $searchText, prompt: "Search recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.loadRecipes()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}
