import SwiftUI

struct DashboardOverviewView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Today’s Transport Overview",
                subtitle: "Live operational summary for the nursery driver"
            )

            TripStatusBannerView(
                title: transportViewModel.tripStatusTitle,
                subtitle: transportViewModel.tripStatusSubtitle,
                isCompleted: transportViewModel.trip.isTripCompleted,
                isActive: transportViewModel.trip.isActive
            )

            ProgressView(value: transportViewModel.completionProgress)
                .progressViewStyle(.linear)

            Text(transportViewModel.completionProgress.percentageText + " completed")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
