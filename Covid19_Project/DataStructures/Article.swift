
import UIKit

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String
    let url: String?
    let urlToImage: String?
    let content: String?

}

