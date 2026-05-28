import Foundation

struct DriverNote: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var message: String
    var createdAt: Date
    var isPinned: Bool

    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        createdAt: Date = Date(),
        isPinned: Bool = false
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.createdAt = createdAt
        self.isPinned = isPinned
    }
}
