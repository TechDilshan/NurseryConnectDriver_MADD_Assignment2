import SwiftUI

struct RouteDistanceBreakdownView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Route Distance Breakdown",
                subtitle: "Stop-to-stop distance information for the driver"
            )

            HStack {
                Text("Total Route Distance")
                    .font(.headline)

                Spacer()

                Text(locationViewModel.totalRouteDistanceText)
                    .font(.headline)
                    .foregroundStyle(.blue)
            }
            .padding()
            .background(Color.appCardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(spacing: 10) {
                ForEach(Array(locationViewModel.stopDistanceRows().enumerated()), id: \.offset) { _, row in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(row.from)
                                .font(.subheadline.weight(.semibold))

                            Text("to \(row.to)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text(row.distance)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.blue)
                    }
                    .padding()
                    .background(Color.appSecondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
