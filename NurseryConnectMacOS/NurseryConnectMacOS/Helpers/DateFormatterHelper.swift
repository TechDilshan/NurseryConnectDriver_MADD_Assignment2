import Foundation

enum DateFormatterHelper {
    static func displayDateTime(_ date: Date?) -> String {
        guard let date else { return "Not available" }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    static func displayTimeOnly(_ date: Date?) -> String {
        guard let date else { return "Not available" }

        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    static func displayDateOnly(_ date: Date?) -> String {
        guard let date else { return "Not available" }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    static func fileSafeDateTime(_ date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm"
        return formatter.string(from: date)
    }
}
