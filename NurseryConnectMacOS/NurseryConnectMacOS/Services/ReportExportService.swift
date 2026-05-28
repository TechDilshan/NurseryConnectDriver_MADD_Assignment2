import Foundation

protocol ReportExportServiceProtocol {
    func generateDailyTransportReport(
        trip: TransportTrip,
        incidents: [IncidentReport]
    ) throws -> URL
}

final class ReportExportService: ReportExportServiceProtocol {
    func generateDailyTransportReport(
        trip: TransportTrip,
        incidents: [IncidentReport]
    ) throws -> URL {
        let reportText = buildReportText(trip: trip, incidents: incidents)

        let fileName = "NurseryConnect_Transport_Report_\(DateFormatterHelper.fileSafeDateTime()).txt"

        let directory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first ?? FileManager.default.temporaryDirectory

        let fileURL = directory.appendingPathComponent(fileName)

        try reportText.write(to: fileURL, atomically: true, encoding: .utf8)

        return fileURL
    }

    private func buildReportText(
        trip: TransportTrip,
        incidents: [IncidentReport]
    ) -> String {
        var text = ""

        text += "\(AppConstants.displayName)\n"
        text += "Daily Transport Report\n"
        text += "Generated: \(DateFormatterHelper.displayDateTime(Date()))\n\n"

        text += "Driver: \(trip.driverName)\n"
        text += "Vehicle: \(trip.vehicleNumber)\n"
        text += "Trip Date: \(DateFormatterHelper.displayDateOnly(trip.tripDate))\n"
        text += "Trip Start: \(DateFormatterHelper.displayDateTime(trip.startTime))\n"
        text += "Trip End: \(DateFormatterHelper.displayDateTime(trip.endTime))\n\n"

        text += "Passenger Summary\n"
        text += "Total Children: \(trip.totalCount)\n"
        text += "Pending: \(trip.pendingCount)\n"
        text += "On Board: \(trip.pickedUpCount)\n"
        text += "Dropped Off: \(trip.droppedOffCount)\n\n"

        text += "Children\n"
        for child in trip.children {
            text += "- \(child.name), \(child.schoolName), Status: \(child.status.title)\n"
        }

        text += "\nIncident Reports\n"
        if incidents.isEmpty {
            text += "No incidents reported.\n"
        } else {
            for incident in incidents {
                text += "- \(incident.childName), \(incident.type.title), \(incident.severity.title), Resolved: \(incident.isResolved ? "Yes" : "No")\n"
            }
        }

        text += "\nCompliance Note\n"
        text += "This MVP avoids login and authentication as required by the assignment. In a production NurseryConnect system, audit logging, encryption, consent management, and role-based access control would be required.\n"

        return text
    }
}
