import Foundation

protocol RoutePreferenceServiceProtocol {
    func saveRoutePriority(_ priority: RoutePriority)
    func loadRoutePriority() -> RoutePriority

    func saveUpdateFrequency(_ value: Double)
    func loadUpdateFrequency() -> Double
}

final class RoutePreferenceService: RoutePreferenceServiceProtocol {
    private let priorityKey = "nurseryconnect_route_priority"
    private let updateFrequencyKey = "nurseryconnect_update_frequency"

    func saveRoutePriority(_ priority: RoutePriority) {
        UserDefaults.standard.set(priority.rawValue, forKey: priorityKey)
    }

    func loadRoutePriority() -> RoutePriority {
        guard let value = UserDefaults.standard.string(forKey: priorityKey),
              let priority = RoutePriority(rawValue: value) else {
            return .balancedRoute
        }

        return priority
    }

    func saveUpdateFrequency(_ value: Double) {
        UserDefaults.standard.set(value, forKey: updateFrequencyKey)
    }

    func loadUpdateFrequency() -> Double {
        let value = UserDefaults.standard.double(forKey: updateFrequencyKey)

        if value == 0 {
            return 10
        }

        return value
    }
}
