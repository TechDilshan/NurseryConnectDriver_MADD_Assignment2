import SwiftUI

struct IncidentReportExportView: View {
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Incident Report Summary",
                subtitle: "Current incident records for the transport run"
            )

            if incidentViewModel.incidents.isEmpty {
                EmptyStateView(
                    title: "No Incidents",
                    message: "There are no incident records for this transport run.",
                    systemImage: "checkmark.seal.fill"
                )
                .frame(height: 220)
            } else {
                ForEach(incidentViewModel.latestIncidents) { incident in
                    HStack(spacing: 14) {
                        Image(systemName: incident.type.systemImage)
                            .foregroundStyle(ChartHelper.incidentColor(for: incident.severity))
                            .frame(width: 42, height: 42)
                            .background(ChartHelper.incidentColor(for: incident.severity).opacity(0.12))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(incident.type.title)
                                .font(.headline)

                            Text("\(incident.childName) • \(DateFormatterHelper.displayDateTime(incident.reportedAt))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        MacStatusPillView(
                            title: incident.isResolved ? "Resolved" : "Open",
                            systemImage: incident.isResolved ? "checkmark.circle.fill" : "clock.fill",
                            color: incident.isResolved ? .green : .orange
                        )
                    }

                    Divider()
                }
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
