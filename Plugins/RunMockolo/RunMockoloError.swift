import Foundation

enum RunMockoloError: Error {
    case invalidURL(String)
}

extension RunMockoloError: LocalizedError {
    var errorDescription: String {
        switch self {
        case let .invalidURL(urlString):
            "Invalid URL: \(urlString)"
        }
    }
}
