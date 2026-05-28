import SwiftUI
import Charts

struct RoutePerformanceChartView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Route Performance",
                subtitle: "Weekly route completion score"
            )

            Chart(analyticsViewModel.weeklyRoutePerformanceData) { item in
                LineMark(
                    x: .value("Day", item.title),
                    y: .value("Score", item.value)
                )
                .symbol(.circle)

                PointMark(
                    x: .value("Day", item.title),
                    y: .value("Score", item.value)
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
