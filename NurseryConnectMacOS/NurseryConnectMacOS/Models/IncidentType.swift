import Foundation

enum IncidentType: String, Codable, CaseIterable, Hashable {
    case latePickup
    case routeDelay
    case childNotFound
    case vehicleIssue
    case medicalConcern
    case safeguardingConcern
    case other

    var title: String {
        switch self {
        case .latePickup:
            return "Late Pickup"
        case .routeDelay:
            return "Route Delay"
        case .childNotFound:
            return "Child Not Found"
        case .vehicleIssue:
            return "Vehicle Issue"
        case .medicalConcern:
            return "Medical Concern"
        case .safeguardingConcern:
            return "Safeguarding Concern"
        case .other:
            return "Other"
        }
    }

    var systemImage: String {
        switch self {
        case .latePickup:
            return "clock.badge.exclamationmark"
        case .routeDelay:
            return "road.lanes"
        case .childNotFound:
            return "person.crop.circle.badge.exclamationmark"
        case .vehicleIssue:
            return "car.fill"
        case .medicalConcern:
            return "cross.case.fill"
        case .safeguardingConcern:
            return "shield.lefthalf.filled"
        case .other:
            return "exclamationmark.triangle.fill"
        }
    }
}
