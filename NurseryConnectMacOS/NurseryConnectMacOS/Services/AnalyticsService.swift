import Foundation

protocol AnalyticsServiceProtocol {
    func pickupStatusData(children: [Child]) -> [AnalyticsDataPoint]
    func incidentSeverityData(incidents: [IncidentReport]) -> [AnalyticsDataPoint]
    func weeklyRoutePerformanceData() -> [AnalyticsDataPoint]
    func driverEfficiencyData() -> [AnalyticsDataPoint]
}

final class AnalyticsService: AnalyticsServiceProtocol {
    func pickupStatusData(children: [Child]) -> [AnalyticsDataPoint] {
        [
            AnalyticsDataPoint(title: "Pending", value: children.filter { $0.status == .pending }.count),
            AnalyticsDataPoint(title: "On Board", value: children.filter { $0.status == .pickedUp }.count),
            AnalyticsDataPoint(title: "Dropped Off", value: children.filter { $0.status == .droppedOff }.count)
        ]
    }

    func incidentSeverityData(incidents: [IncidentReport]) -> [AnalyticsDataPoint] {
        [
            AnalyticsDataPoint(title: "Low", value: incidents.filter { $0.severity == .low }.count),
            AnalyticsDataPoint(title: "Medium", value: incidents.filter { $0.severity == .medium }.count),
            AnalyticsDataPoint(title: "High", value: incidents.filter { $0.severity == .high }.count)
        ]
    }

    func weeklyRoutePerformanceData() -> [AnalyticsDataPoint] {
        [
            AnalyticsDataPoint(title: "Mon", value: 92),
            AnalyticsDataPoint(title: "Tue", value: 88),
            AnalyticsDataPoint(title: "Wed", value: 95),
            AnalyticsDataPoint(title: "Thu", value: 90),
            AnalyticsDataPoint(title: "Fri", value: 97)
        ]
    }

    func driverEfficiencyData() -> [AnalyticsDataPoint] {
        [
            AnalyticsDataPoint(title: "On Time", value: 8),
            AnalyticsDataPoint(title: "Delayed", value: 2),
            AnalyticsDataPoint(title: "Completed", value: 10)
        ]
    }
}
