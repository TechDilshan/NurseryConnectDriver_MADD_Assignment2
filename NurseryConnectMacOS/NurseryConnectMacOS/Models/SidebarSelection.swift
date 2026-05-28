import Foundation

enum SidebarSelection: String, CaseIterable, Identifiable, Hashable {
    case dashboard
    case liveRoute
    case manifest
    case incidents
    case analytics
    case reports
    case notes
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .liveRoute:
            return "Live Route"
        case .manifest:
            return "Manifest"
        case .incidents:
            return "Incidents"
        case .analytics:
            return "Analytics"
        case .reports:
            return "Reports"
        case .notes:
            return "Driver Notes"
        case .settings:
            return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .dashboard:
            return "rectangle.grid.2x2.fill"
        case .liveRoute:
            return "map.fill"
        case .manifest:
            return "person.3.fill"
        case .incidents:
            return "exclamationmark.triangle.fill"
        case .analytics:
            return "chart.bar.xaxis"
        case .reports:
            return "doc.text.fill"
        case .notes:
            return "note.text"
        case .settings:
            return "gearshape.fill"
        }
    }
}
