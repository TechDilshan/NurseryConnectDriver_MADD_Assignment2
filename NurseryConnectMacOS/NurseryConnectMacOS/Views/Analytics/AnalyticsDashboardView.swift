import SwiftUI
import Charts

struct AnalyticsDashboardView: View {
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header

                HStack(spacing: 16) {
                    AnalyticsSummaryCard(
                        title: "Pickup Records",
                        value: "\(analyticsViewModel.totalPickupItems)",
                        subtitle: "Children in today’s manifest",
                        systemImage: "person.3.fill",
                        color: .blue
                    )

                    AnalyticsSummaryCard(
                        title: "Incidents",
                        value: "\(analyticsViewModel.totalIncidents)",
                        subtitle: "Recorded safety events",
                        systemImage: "exclamationmark.triangle.fill",
                        color: .orange
                    )

                    AnalyticsSummaryCard(
                        title: "Route Score",
                        value: "\(analyticsViewModel.averageWeeklyPerformance)%",
                        subtitle: "Weekly average",
                        systemImage: "speedometer",
                        color: .green
                    )
                }

                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 420), spacing: 20)
                    ],
                    spacing: 20
                ) {
                    PickupChartView()
                    IncidentChartView()
                    RoutePerformanceChartView()
                    WeeklyTripsChartView()
                    DriverEfficiencyChartView()
                }
            }
            .padding(28)
        }
        .onAppear {
            analyticsViewModel.refresh(
                children: transportViewModel.children,
                incidents: incidentViewModel.incidents
            )
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Transport Analytics")
                .font(.largeTitle.bold())

            Text("Swift Charts dashboard for pickup progress, incident severity, route performance, and driver efficiency.")
                .foregroundStyle(.secondary)
        }
    }
}
