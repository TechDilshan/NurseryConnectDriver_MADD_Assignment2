import Foundation

struct TripHistoryRecord: Identifiable, Codable, Hashable {
    let id: UUID
    var date: Date
    var driverName: String
    var vehicleNumber: String
    var totalChildren: Int
    var completedChildren: Int
    var incidentCount: Int
    var notes: String

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        driverName: String = AppConstants.defaultDriverName,
        vehicleNumber: String = AppConstants.vehicleNumber,
        totalChildren: Int,
        completedChildren: Int,
        incidentCount: Int,
        notes: String = ""
    ) {
        self.id = id
        self.date = date
        self.driverName = driverName
        self.vehicleNumber = vehicleNumber
        self.totalChildren = totalChildren
        self.completedChildren = completedChildren
        self.incidentCount = incidentCount
        self.notes = notes
    }

    var completionText: String {
        "\(completedChildren)/\(totalChildren)"
    }
}
