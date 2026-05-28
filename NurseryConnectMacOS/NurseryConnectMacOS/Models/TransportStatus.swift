import Foundation

enum TransportStatus: String, Codable, CaseIterable, Hashable {
    case pending
    case pickedUp
    case droppedOff

    var title: String {
        switch self {
        case .pending:
            return "Pending"
        case .pickedUp:
            return "On Board"
        case .droppedOff:
            return "Dropped Off"
        }
    }

    var systemImage: String {
        switch self {
        case .pending:
            return "clock.fill"
        case .pickedUp:
            return "bus.fill"
        case .droppedOff:
            return "checkmark.circle.fill"
        }
    }
}
