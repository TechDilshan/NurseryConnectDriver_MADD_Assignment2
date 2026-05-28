import Foundation
import SwiftUI

@MainActor
final class TripHistoryViewModel: ObservableObject {
    @Published var records: [TripHistoryRecord] = []
    @Published var successMessage: String?
    @Published var errorMessage: String?

    private let key = "nurseryconnect_macos_trip_history_records"

    init() {
        loadRecords()
    }

    var latestRecords: [TripHistoryRecord] {
        records.sorted { $0.date > $1.date }
    }

    func addRecord(from trip: TransportTrip, incidentCount: Int) {
        let record = TripHistoryRecord(
            date: Date(),
            driverName: trip.driverName,
            vehicleNumber: trip.vehicleNumber,
            totalChildren: trip.totalCount,
            completedChildren: trip.droppedOffCount,
            incidentCount: incidentCount,
            notes: trip.isTripCompleted ? "Trip completed." : "Trip still in progress."
        )

        withAnimation(.spring()) {
            records.insert(record, at: 0)
        }

        saveRecords()
        successMessage = "Trip history record saved."
    }

    func deleteRecord(_ record: TripHistoryRecord) {
        withAnimation(.easeInOut) {
            records.removeAll { $0.id == record.id }
        }

        saveRecords()
        successMessage = "Trip history record deleted."
    }

    func clearAll() {
        records.removeAll()
        saveRecords()
        successMessage = "Trip history cleared."
    }

    private func saveRecords() {
        do {
            let data = try JSONEncoder().encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            errorMessage = "Failed to save trip history."
        }
    }

    private func loadRecords() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            records = sampleRecords
            return
        }

        do {
            records = try JSONDecoder().decode([TripHistoryRecord].self, from: data)
        } catch {
            records = sampleRecords
            errorMessage = "Failed to load saved trip history."
        }
    }

    private var sampleRecords: [TripHistoryRecord] {
        [
            TripHistoryRecord(
                date: Date().addingTimeInterval(-86400),
                driverName: AppConstants.defaultDriverName,
                vehicleNumber: AppConstants.vehicleNumber,
                totalChildren: 4,
                completedChildren: 4,
                incidentCount: 0,
                notes: "Completed without issues."
            ),
            TripHistoryRecord(
                date: Date().addingTimeInterval(-172800),
                driverName: AppConstants.defaultDriverName,
                vehicleNumber: AppConstants.vehicleNumber,
                totalChildren: 4,
                completedChildren: 4,
                incidentCount: 1,
                notes: "One route delay was reported."
            )
        ]
    }
}
