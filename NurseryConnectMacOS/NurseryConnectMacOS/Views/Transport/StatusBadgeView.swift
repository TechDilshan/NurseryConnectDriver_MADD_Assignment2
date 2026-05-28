import SwiftUI

struct StatusBadgeView: View {
    let status: TransportStatus

    var body: some View {
        Label(status.title, systemImage: status.systemImage)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .foregroundStyle(textColor)
            .background(backgroundColor)
            .clipShape(Capsule())
    }

    private var backgroundColor: Color {
        switch status {
        case .pending:
            return .orange.opacity(0.16)
        case .pickedUp:
            return .blue.opacity(0.16)
        case .droppedOff:
            return .green.opacity(0.16)
        }
    }

    private var textColor: Color {
        switch status {
        case .pending:
            return .orange
        case .pickedUp:
            return .blue
        case .droppedOff:
            return .green
        }
    }
}
