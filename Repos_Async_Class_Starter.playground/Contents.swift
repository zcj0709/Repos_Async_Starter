import SwiftUI
import Foundation

// Simplified decodable structs from earlier exercise
struct Repositories: Decodable {
    let repos: [Repository]
    
    enum CodingKeys : String, CodingKey {
        case repos = "items"
    }
}

struct Repository: Decodable {
    let name: String
    let htmlURL: String
    
    enum CodingKeys : String, CodingKey {
        case name
        case htmlURL = "html_url"
    }
}

// Our initial function (needs fixing...)
func fetchRepositories() async throws -> [Repository] {
    let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Repositories.self, from: data).repos
}


// A task to utilize this function
// - call function then loop over repos array to print out the name & url for each
// - interject lots of print statements with 'Step X' to see how things are progressing
Task {
    print("Step 1: Start")
    do {
        print("Step 2: Fetch the Repositories")
        let repos = try await fetchRepositories()
        print("Step 3: Print Each Repo")
        for repo in repos{
            print("\(repo.name): \(repo.htmlURL)")
        }
    }
    catch {
        print("Error")
    }
    
    print("Step 4: Print End")
    // ...
    
    
}
print("Step 5: Task Finish")
