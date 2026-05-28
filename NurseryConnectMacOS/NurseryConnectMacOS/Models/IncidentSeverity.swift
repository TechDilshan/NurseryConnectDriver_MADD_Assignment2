import Foundation

enum IncidentSeverity: String, Codable, CaseIterable, Hashable {
    case low
    case medium
    case high

    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}
