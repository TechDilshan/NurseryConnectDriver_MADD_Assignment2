import SwiftUI

struct RouteInfoCardView: View {
    let title: String
    let subtitle: String
    let systemImage: String
    var extraInfo: String? = nil

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 46, height: 46)
                .background(Color.blue.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let extraInfo {
                    Text(extraInfo)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
