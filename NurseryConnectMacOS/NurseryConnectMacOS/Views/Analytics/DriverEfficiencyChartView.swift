import SwiftUI
import Charts

struct DriverEfficiencyChartView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Driver Efficiency",
                subtitle: "On-time, delayed, and completed records"
            )

            Chart(analyticsViewModel.driverEfficiencyData) { item in
                BarMark(
                    x: .value("Category", item.title),
                    y: .value("Value", item.value)
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
