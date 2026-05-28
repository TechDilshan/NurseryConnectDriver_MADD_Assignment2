import Foundation
import SwiftUI

@MainActor
final class IncidentViewModel: ObservableObject {
    @Published var incidents: [IncidentReport]
    @Published var selectedIncident: IncidentReport?
    @Published var successMessage: String?
    @Published var errorMessage: String?

    @Published var childName: String = ""
    @Published var selectedType: IncidentType = .routeDelay
    @Published var selectedSeverity: IncidentSeverity = .low
    @Published var location: String = ""
    @Published var incidentDescription: String = ""
    @Published var actionTaken: String = ""

    private let storageService: IncidentStorageServiceProtocol

    init(storageService: IncidentStorageServiceProtocol = IncidentStorageService()) {
        self.storageService = storageService
        self.incidents = storageService.loadIncidents()
    }

    var unresolvedIncidents: [IncidentReport] {
        incidents.filter { !$0.isResolved }
    }

    var resolvedIncidents: [IncidentReport] {
        incidents.filter { $0.isResolved }
    }

    var highSeverityCount: Int {
        incidents.filter { $0.severity == .high }.count
    }

    var latestIncidents: [IncidentReport] {
        incidents.sorted { $0.reportedAt > $1.reportedAt }
    }

    func addIncident() {
        guard validateForm() else { return }

        let report = IncidentReport(
            childName: childName.trimmedText,
            type: selectedType,
            severity: selectedSeverity,
            location: location.trimmedText,
            description: incidentDescription.trimmedText,
            actionTaken: actionTaken.trimmedText,
            reportedBy: AppConstants.defaultDriverName,
            isResolved: false
        )

        withAnimation(.spring()) {
            incidents.insert(report, at: 0)
        }

        saveChanges()
        resetForm()
        showSuccess("Incident report created successfully.")
    }

    func markResolved(_ incident: IncidentReport) {
        guard let index = incidents.firstIndex(where: { $0.id == incident.id }) else {
            showError("Incident record could not be found.")
            return
        }

        withAnimation(.easeInOut) {
            incidents[index].isResolved = true
        }

        saveChanges()
        showSuccess("Incident marked as resolved.")
    }

    func deleteIncident(_ incident: IncidentReport) {
        withAnimation(.easeInOut) {
            incidents.removeAll { $0.id == incident.id }
        }

        saveChanges()
        showSuccess("Incident deleted.")
    }

    func resetForm() {
        childName = ""
        selectedType = .routeDelay
        selectedSeverity = .low
        location = ""
        incidentDescription = ""
        actionTaken = ""
    }

    func clearMessages() {
        successMessage = nil
        errorMessage = nil
    }

    private func validateForm() -> Bool {
        if childName.isBlank {
            showError("Please enter the child name.")
            return false
        }

        if location.isBlank {
            showError("Please enter the incident location.")
            return false
        }

        if incidentDescription.isBlank {
            showError("Please enter the incident description.")
            return false
        }

        if actionTaken.isBlank {
            showError("Please enter the action taken.")
            return false
        }

        return true
    }

    private func saveChanges() {
        storageService.saveIncidents(incidents)
    }

    private func showSuccess(_ message: String) {
        successMessage = message
        errorMessage = nil
    }

    private func showError(_ message: String) {
        errorMessage = message
        successMessage = nil
    }
}
