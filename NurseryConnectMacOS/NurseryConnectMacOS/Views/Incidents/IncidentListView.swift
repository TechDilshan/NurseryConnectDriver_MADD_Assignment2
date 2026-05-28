import SwiftUI

struct IncidentListView: View {
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @EnvironmentObject var navigationViewModel: MacNavigationViewModel

    @State private var selectedIncident: IncidentReport?

    var body: some View {
        HStack(spacing: 22) {
            VStack(alignment: .leading, spacing: 18) {
                header

                HStack(spacing: 14) {
                    IncidentSummaryCardView()

                    DashboardMetricCard(
                        title: "High Severity",
                        value: "\(incidentViewModel.highSeverityCount)",
                        subtitle: "Needs manager attention",
                        systemImage: "shield.lefthalf.filled",
                        color: .red
                    )
                }

                List(selection: $selectedIncident) {
                    Section("Open Incidents") {
                        ForEach(incidentViewModel.unresolvedIncidents) { incident in
                            incidentRow(incident)
                                .tag(incident)
                        }
                    }

                    Section("Resolved Incidents") {
                        ForEach(incidentViewModel.resolvedIncidents) { incident in
                            incidentRow(incident)
                                .tag(incident)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .frame(minWidth: 500)

            if let selectedIncident {
                IncidentDetailView(incident: selectedIncident)
                    .frame(maxWidth: .infinity)
            } else {
                EmptyStateView(
                    title: "Select an Incident",
                    message: "Choose an incident to view full details, action taken, and resolution status.",
                    systemImage: "exclamationmark.bubble.fill"
                )
                .frame(maxWidth: .infinity)
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 22))
            }
        }
        .padding(28)
        .sheet(isPresented: $navigationViewModel.showingIncidentForm) {
            IncidentFormView()
                .environmentObject(incidentViewModel)
                .frame(minWidth: 520, minHeight: 600)
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Incident Reporting")
                    .font(.largeTitle.bold())

                Text("Record transport safety events such as route delays, late pickup, child not found, vehicle issues, or safeguarding concerns.")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                navigationViewModel.openIncidentForm()
            } label: {
                Label("New Incident", systemImage: "plus.circle.fill")
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private func incidentRow(_ incident: IncidentReport) -> some View {
        HStack(spacing: 14) {
            Image(systemName: incident.type.systemImage)
                .foregroundStyle(severityColor(incident.severity))
                .frame(width: 40, height: 40)
                .background(severityColor(incident.severity).opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(incident.type.title)
                    .font(.headline)

                Text(incident.childName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(DateFormatterHelper.displayDateTime(incident.reportedAt))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            MacStatusPillView(
                title: incident.severity.title,
                systemImage: "flag.fill",
                color: severityColor(incident.severity)
            )
        }
        .padding(.vertical, 6)
        .accessibilityLabel(AccessibilityHelper.incidentLabel(type: incident.type, severity: incident.severity))
    }

    private func severityColor(_ severity: IncidentSeverity) -> Color {
        ChartHelper.incidentColor(for: severity)
    }
}
