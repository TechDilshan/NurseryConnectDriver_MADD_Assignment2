import SwiftUI

enum AccessibilityHelper {
    static func childStatusLabel(name: String, status: TransportStatus) -> String {
        "\(name), transport status \(status.title)"
    }

    static func tripProgressLabel(progress: Double) -> String {
        "Trip progress \(Int(progress * 100)) percent completed"
    }

    static func incidentLabel(type: IncidentType, severity: IncidentSeverity) -> String {
        "Incident type \(type.title), severity \(severity.title)"
    }

    static func chartLabel(title: String, value: Int) -> String {
        "\(title), value \(value)"
    }
}
