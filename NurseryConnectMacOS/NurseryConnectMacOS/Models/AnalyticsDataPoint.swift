import Foundation

struct AnalyticsDataPoint: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var value: Int

    init(id: UUID = UUID(), title: String, value: Int) {
        self.id = id
        self.title = title
        self.value = value
    }
}
