import SwiftUI

struct DailyReportView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header

                HStack(spacing: 16) {
                    DashboardMetricCard(
                        title: "Total Children",
                        value: "\(transportViewModel.trip.totalCount)",
                        subtitle: "Today’s assigned passengers",
                        systemImage: "person.3.fill",
                        color: .blue
                    )

                    DashboardMetricCard(
                        title: "Completed",
                        value: "\(transportViewModel.droppedOffCount)",
                        subtitle: "Dropped off safely",
                        systemImage: "checkmark.seal.fill",
                        color: .green
                    )

                    DashboardMetricCard(
                        title: "Incidents",
                        value: "\(incidentViewModel.incidents.count)",
                        subtitle: "Safety records",
                        systemImage: "exclamationmark.triangle.fill",
                        color: .orange
                    )
                }

                VStack(alignment: .leading, spacing: 16) {
                    SectionHeaderView(
                        title: "Passenger Report",
                        subtitle: "Current child transport status"
                    )

                    ForEach(transportViewModel.children) { child in
                        ChildRowView(child: child)
                        Divider()
                    }
                }
                .padding()
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                IncidentReportExportView()

                ComplianceNotesView()
            }
            .padding(28)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Daily Transport Report")
                .font(.largeTitle.bold())

            Text("Summary of today’s route, child pickup status, incident records, and compliance notes.")
                .foregroundStyle(.secondary)
        }
    }
}
