import SwiftUI

enum ChartHelper {
    static func statusColor(for status: TransportStatus) -> Color {
        switch status {
        case .pending:
            return .orange
        case .pickedUp:
            return .blue
        case .droppedOff:
            return .green
        }
    }

    static func incidentColor(for severity: IncidentSeverity) -> Color {
        switch severity {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }

    static func chartSymbolName(for index: Int) -> String {
        let symbols = [
            "circle.fill",
            "square.fill",
            "triangle.fill",
            "diamond.fill"
        ]

        return symbols[index % symbols.count]
    }
}
