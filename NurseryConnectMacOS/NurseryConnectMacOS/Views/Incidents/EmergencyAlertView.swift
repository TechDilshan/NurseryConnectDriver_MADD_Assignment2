import SwiftUI

struct EmergencyAlertView: View {
    let severity: IncidentSeverity

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundStyle(color)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var color: Color {
        ChartHelper.incidentColor(for: severity)
    }

    private var icon: String {
        severity == .high ? "shield.lefthalf.filled" : "info.circle.fill"
    }

    private var title: String {
        switch severity {
        case .low:
            return "Low Priority Note"
        case .medium:
            return "Manager Review Recommended"
        case .high:
            return "High Priority Safeguarding Alert"
        }
    }

    private var message: String {
        switch severity {
        case .low:
            return "This incident should be kept for daily transport records."
        case .medium:
            return "The Setting Manager should review this record before the end of the day."
        case .high:
            return "This record should be escalated immediately in a real nursery environment."
        }
    }
}
