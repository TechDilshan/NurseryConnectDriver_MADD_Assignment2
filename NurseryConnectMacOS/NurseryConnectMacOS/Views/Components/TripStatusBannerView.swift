import SwiftUI

struct TripStatusBannerView: View {
    let title: String
    let subtitle: String
    let isCompleted: Bool
    let isActive: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 46, height: 46)
                .background(badgeColor)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.appCardBackground)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(badgeColor.opacity(0.25), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private var badgeColor: Color {
        if isCompleted { return .green }
        if isActive { return .blue }
        return .orange
    }

    private var iconName: String {
        if isCompleted { return "checkmark.seal.fill" }
        if isActive { return "car.fill" }
        return "clock.fill"
    }
}
