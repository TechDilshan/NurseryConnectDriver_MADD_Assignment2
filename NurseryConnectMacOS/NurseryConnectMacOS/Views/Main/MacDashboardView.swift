import SwiftUI

struct MacDashboardView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection

                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 220), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    DashboardMetricCard(
                        title: "Total Children",
                        value: "\(transportViewModel.children.count)",
                        subtitle: "Assigned to today's route",
                        systemImage: "person.3.fill",
                        color: .blue
                    )

                    DashboardMetricCard(
                        title: "On Board",
                        value: "\(transportViewModel.onboardCount)",
                        subtitle: "Currently inside vehicle",
                        systemImage: "bus.fill",
                        color: .indigo
                    )

                    DashboardMetricCard(
                        title: "Dropped Off",
                        value: "\(transportViewModel.droppedOffCount)",
                        subtitle: "Safely completed",
                        systemImage: "checkmark.seal.fill",
                        color: .green
                    )

                    DashboardMetricCard(
                        title: "Open Incidents",
                        value: "\(incidentViewModel.unresolvedIncidents.count)",
                        subtitle: "Require attention",
                        systemImage: "exclamationmark.triangle.fill",
                        color: .orange
                    )
                }

                HStack(alignment: .top, spacing: 20) {
                    VStack(spacing: 20) {
                        VehicleStatusView()
                        DailySummaryView()
                    }
                    .frame(maxWidth: 420)

                    VStack(spacing: 20) {
                        DriverPerformanceView()
                        IncidentSummaryCardView()
                    }
                    .frame(maxWidth: .infinity)
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

    private var headerSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Driver Operations Center")
                    .font(.largeTitle.bold())

                Text("Monitor today’s nursery transport route, passenger safety, route progress, and reported incidents.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            MacStatusPillView(
                title: transportViewModel.tripStatusTitle,
                systemImage: transportViewModel.trip.isActive ? "car.fill" : "clock.fill",
                color: transportViewModel.trip.isTripCompleted ? .green : .blue
            )
        }
    }
}
