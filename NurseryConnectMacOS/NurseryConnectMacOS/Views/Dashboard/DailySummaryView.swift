import SwiftUI

struct DailySummaryView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Daily Summary",
                subtitle: "Passenger progress for today"
            )

            HStack {
                MacStatusPillView(
                    title: "Pending \(transportViewModel.pendingCount)",
                    systemImage: "clock.fill",
                    color: .orange
                )

                MacStatusPillView(
                    title: "On Board \(transportViewModel.onboardCount)",
                    systemImage: "bus.fill",
                    color: .blue
                )

                MacStatusPillView(
                    title: "Dropped \(transportViewModel.droppedOffCount)",
                    systemImage: "checkmark.circle.fill",
                    color: .green
                )
            }

            ForEach(transportViewModel.children.prefix(4)) { child in
                ChildRowView(child: child)
                Divider()
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
