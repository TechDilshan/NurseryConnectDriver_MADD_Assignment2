import SwiftUI

struct ChildRowView: View {
    let child: Child

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Color.blue.opacity(0.15))
                .frame(width: 46, height: 46)
                .overlay {
                    Text(child.initials)
                        .font(.headline.bold())
                        .foregroundStyle(.blue)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(child.name)
                    .font(.headline)

                Text(child.schoolName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("Pickup: \(child.pickupLocation)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            StatusBadgeView(status: child.status)
        }
        .padding(.vertical, 8)
        .accessibilityLabel(AccessibilityHelper.childStatusLabel(name: child.name, status: child.status))
    }
}
