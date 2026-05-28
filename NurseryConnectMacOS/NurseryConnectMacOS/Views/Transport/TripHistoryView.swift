import SwiftUI

struct TripHistoryView: View {
    @EnvironmentObject var tripHistoryViewModel: TripHistoryViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SectionHeaderView(
                title: "Trip History",
                subtitle: "Saved transport records for operational review"
            )

            if tripHistoryViewModel.records.isEmpty {
                EmptyStateView(
                    title: "No History Available",
                    message: "Save a trip record from the toolbar to view it here.",
                    systemImage: "archivebox.fill"
                )
            } else {
                List {
                    ForEach(tripHistoryViewModel.latestRecords) { record in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(DateFormatterHelper.displayDateOnly(record.date))
                                    .font(.headline)

                                Spacer()

                                MacStatusPillView(
                                    title: record.completionText,
                                    systemImage: "checkmark.circle.fill",
                                    color: .green
                                )
                            }

                            Text("Vehicle: \(record.vehicleNumber)")
                                .foregroundStyle(.secondary)

                            Text("Incidents: \(record.incidentCount)")
                                .foregroundStyle(.secondary)

                            Text(record.notes)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            tripHistoryViewModel.deleteRecord(tripHistoryViewModel.latestRecords[index])
                        }
                    }
                }
            }
        }
        .padding(28)
    }
}
