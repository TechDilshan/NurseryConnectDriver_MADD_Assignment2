import SwiftUI

struct IncidentDetailView: View {
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    let incident: IncidentReport

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack(alignment: .top, spacing: 18) {
                    Image(systemName: incident.type.systemImage)
                        .font(.largeTitle)
                        .foregroundStyle(ChartHelper.incidentColor(for: incident.severity))
                        .frame(width: 72, height: 72)
                        .background(ChartHelper.incidentColor(for: incident.severity).opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 18))

                    VStack(alignment: .leading, spacing: 8) {
                        Text(incident.type.title)
                            .font(.largeTitle.bold())

                        Text("Reported for \(incident.childName)")
                            .foregroundStyle(.secondary)

                        HStack {
                            MacStatusPillView(
                                title: incident.severity.title,
                                systemImage: "flag.fill",
                                color: ChartHelper.incidentColor(for: incident.severity)
                            )

                            MacStatusPillView(
                                title: incident.isResolved ? "Resolved" : "Open",
                                systemImage: incident.isResolved ? "checkmark.seal.fill" : "clock.fill",
                                color: incident.isResolved ? .green : .orange
                            )
                        }
                    }

                    Spacer()
                }

                detailSection(title: "Location", value: incident.location)
                detailSection(title: "Reported By", value: incident.reportedBy)
                detailSection(title: "Reported At", value: DateFormatterHelper.displayDateTime(incident.reportedAt))
                detailSection(title: "Description", value: incident.description)
                detailSection(title: "Action Taken", value: incident.actionTaken)

                HStack(spacing: 14) {
                    Button {
                        incidentViewModel.markResolved(incident)
                    } label: {
                        PrimaryButton(title: "Mark as Resolved", systemImage: "checkmark.circle.fill", color: .green)
                    }
                    .disabled(incident.isResolved)

                    Button {
                        incidentViewModel.deleteIncident(incident)
                    } label: {
                        PrimaryButton(title: "Delete", systemImage: "trash.fill", color: .red)
                    }
                }

                EmergencyAlertView(severity: incident.severity)
            }
            .padding(28)
        }
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private func detailSection(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(value)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
