import SwiftUI

struct ExportReportView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var exportedURL: URL?
    @State private var errorMessage: String?

    private let reportService: ReportExportServiceProtocol = ReportExportService()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                SectionHeaderView(
                    title: "Export Daily Transport Report",
                    subtitle: "Generate a local text report for demonstration and compliance documentation."
                )

                InfoCardView(
                    title: "Vehicle",
                    value: transportViewModel.trip.vehicleNumber,
                    systemImage: "car.fill"
                )

                InfoCardView(
                    title: "Children",
                    value: "\(transportViewModel.trip.totalCount)",
                    systemImage: "person.3.fill"
                )

                InfoCardView(
                    title: "Incidents",
                    value: "\(incidentViewModel.incidents.count)",
                    systemImage: "exclamationmark.triangle.fill"
                )

                if let exportedURL {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Report Exported")
                            .font(.headline)

                        Text(exportedURL.path)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .textSelection(.enabled)
                    }
                    .padding()
                    .background(Color.green.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                Spacer()

                Button {
                    exportReport()
                } label: {
                    PrimaryButton(title: "Generate Report", systemImage: "doc.text.fill", color: .blue)
                }
            }
            .padding(28)
            .navigationTitle("Export Report")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func exportReport() {
        do {
            exportedURL = try reportService.generateDailyTransportReport(
                trip: transportViewModel.trip,
                incidents: incidentViewModel.incidents
            )
            errorMessage = nil
        } catch {
            errorMessage = "Failed to export report: \(error.localizedDescription)"
        }
    }
}
