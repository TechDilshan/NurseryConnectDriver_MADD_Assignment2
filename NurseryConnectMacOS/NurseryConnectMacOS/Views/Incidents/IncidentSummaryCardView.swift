import SwiftUI

struct IncidentSummaryCardView: View {
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some View {
        DashboardMetricCard(
            title: "Open Incidents",
            value: "\(incidentViewModel.unresolvedIncidents.count)",
            subtitle: "\(incidentViewModel.resolvedIncidents.count) resolved records",
            systemImage: "exclamationmark.triangle.fill",
            color: .orange
        )
    }
}
