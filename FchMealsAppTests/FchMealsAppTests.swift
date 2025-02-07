//
//  FchMealsAppTests.swift
//  FchMealsAppTests
//
//  Created by Aadi Shiv Malhotra on 2/7/25.
//

import Testing
@testable import FchMealsApp
import Foundation

struct RecipeServiceTests  {
    @Test
    func testFetchRecipesSuccess() async throws {
        let recipes = try await RecipeService.shared.fetchRecipes()
        #expect(!recipes.isEmpty)
    }

    @Test
    func testImageCaching() async throws {
        let imageCache = ImageCache.shared
        let imageURL = URL(string: "https://some.url/small.jpg")!

        let image = await imageCache.loadImage(from: imageURL)
        #expect(image != nil)
    }
}
