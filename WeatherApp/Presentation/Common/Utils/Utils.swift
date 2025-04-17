import Foundation

func stringRes(_ resource: String) -> String {
    NSLocalizedString(resource, comment: String.empty)
}

func getDefaultURIComponents(host: String, path: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    return components
}
