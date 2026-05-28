import SwiftUI
import Charts

struct WeeklyTripsChartView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Weekly Trips",
                subtitle: "Completed transport runs by day"
            )

            Chart(analyticsViewModel.weeklyRoutePerformanceData) { item in
                BarMark(
                    x: .value("Day", item.title),
                    y: .value("Completion", item.value)
                )
            }
            .chartYScale(domain: 0...100)
            .frame(height: 220)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
