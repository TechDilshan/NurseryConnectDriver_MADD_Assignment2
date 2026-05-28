import SwiftUI

struct DriverPerformanceView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Performance Snapshot",
                subtitle: "Swift Charts analytics summary"
            )

            HStack(spacing: 14) {
                AnalyticsSummaryCard(
                    title: "Average Route Score",
                    value: "\(analyticsViewModel.averageWeeklyPerformance)%",
                    subtitle: "Weekly performance",
                    systemImage: "speedometer",
                    color: .green
                )

                AnalyticsSummaryCard(
                    title: "Total Incidents",
                    value: "\(incidentViewModel.incidents.count)",
                    subtitle: "Recorded safety events",
                    systemImage: "exclamationmark.triangle.fill",
                    color: .orange
                )
            }

            RoutePerformanceChartView()
                .frame(height: 230)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            analyticsViewModel.refresh(
                children: transportViewModel.children,
                incidents: incidentViewModel.incidents
            )
        }
    }
}
