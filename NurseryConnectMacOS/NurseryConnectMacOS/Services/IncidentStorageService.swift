import Foundation

protocol IncidentStorageServiceProtocol {
    func saveIncidents(_ incidents: [IncidentReport])
    func loadIncidents() -> [IncidentReport]
    func clearIncidents()
}

final class IncidentStorageService: IncidentStorageServiceProtocol {
    private let key = "nurseryconnect_macos_incident_reports"

    func saveIncidents(_ incidents: [IncidentReport]) {
        do {
            let data = try JSONEncoder().encode(incidents)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save incidents: \(error.localizedDescription)")
        }
    }

    func loadIncidents() -> [IncidentReport] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return sampleIncidents
        }

        do {
            return try JSONDecoder().decode([IncidentReport].self, from: data)
        } catch {
            print("Failed to load incidents: \(error.localizedDescription)")
            return sampleIncidents
        }
    }

    func clearIncidents() {
        UserDefaults.standard.removeObject(forKey: key)
    }

    private var sampleIncidents: [IncidentReport] {
        [
            IncidentReport(
                childName: "Emma Johnson",
                type: .latePickup,
                severity: .low,
                location: "Little Stars Preschool",
                description: "Pickup was delayed due to school gate congestion.",
                actionTaken: "Driver informed nursery manager and updated route timing.",
                reportedBy: AppConstants.defaultDriverName,
                isResolved: true
            ),
            IncidentReport(
                childName: "Liam Smith",
                type: .routeDelay,
                severity: .medium,
                location: "Main Road",
                description: "Unexpected traffic delay during nursery transport route.",
                actionTaken: "ETA was updated and the transport run continued safely.",
                reportedBy: AppConstants.defaultDriverName,
                isResolved: false
            )
        ]
    }
}
