import SwiftUI
import Charts

struct PickupChartView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Pickup Status",
                subtitle: "Current passenger status summary"
            )

            Chart(analyticsViewModel.pickupStatusData) { item in
                BarMark(
                    x: .value("Status", item.title),
                    y: .value("Count", item.value)
                )
                .annotation(position: .top) {
                    Text("\(item.value)")
                        .font(.caption.bold())
                }
            }
            .frame(height: 220)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
