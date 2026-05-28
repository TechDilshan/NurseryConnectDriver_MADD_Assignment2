import Foundation

protocol NotificationServiceProtocol {
    func successMessage(_ message: String) -> AppNotification
    func warningMessage(_ message: String) -> AppNotification
    func errorMessage(_ message: String) -> AppNotification
}

final class NotificationService: NotificationServiceProtocol {
    func successMessage(_ message: String) -> AppNotification {
        AppNotification(
            title: "Success",
            message: message,
            type: .success
        )
    }

    func warningMessage(_ message: String) -> AppNotification {
        AppNotification(
            title: "Warning",
            message: message,
            type: .warning
        )
    }

    func errorMessage(_ message: String) -> AppNotification {
        AppNotification(
            title: "Error",
            message: message,
            type: .error
        )
    }
}

struct AppNotification: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let message: String
    let type: AppNotificationType
}

enum AppNotificationType: String {
    case success
    case warning
    case error
}
