import Foundation

struct IncidentReport: Identifiable, Codable, Hashable {
    let id: UUID
    var childName: String
    var type: IncidentType
    var severity: IncidentSeverity
    var location: String
    var description: String
    var actionTaken: String
    var reportedBy: String
    var reportedAt: Date
    var isResolved: Bool

    init(
        id: UUID = UUID(),
        childName: String,
        type: IncidentType,
        severity: IncidentSeverity,
        location: String,
        description: String,
        actionTaken: String,
        reportedBy: String = AppConstants.defaultDriverName,
        reportedAt: Date = Date(),
        isResolved: Bool = false
    ) {
        self.id = id
        self.childName = childName
        self.type = type
        self.severity = severity
        self.location = location
        self.description = description
        self.actionTaken = actionTaken
        self.reportedBy = reportedBy
        self.reportedAt = reportedAt
        self.isResolved = isResolved
    }
}
