import SwiftUI

struct AnalyticsSummaryCard: View {
    let title: String
    let value: String
    let subtitle: String
    let systemImage: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundStyle(color)

                Text(title)
                    .font(.headline)

                Spacer()
            }

            Text(value)
                .font(.largeTitle.bold())

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
