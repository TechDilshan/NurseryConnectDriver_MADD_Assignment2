import Foundation

enum RoutePriority: String, CaseIterable, Codable, Hashable {
    case safetyFirst
    case fastestRoute
    case balancedRoute

    var title: String {
        switch self {
        case .safetyFirst:
            return "Safety First"
        case .fastestRoute:
            return "Fastest Route"
        case .balancedRoute:
            return "Balanced Route"
        }
    }

    var description: String {
        switch self {
        case .safetyFirst:
            return "Prioritises safer roads and careful transport decisions."
        case .fastestRoute:
            return "Prioritises shorter travel time."
        case .balancedRoute:
            return "Balances safety, distance, and estimated arrival time."
        }
    }
}
