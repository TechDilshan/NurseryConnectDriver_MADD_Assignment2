import Foundation
import SwiftUI

@MainActor
final class DriverNotesViewModel: ObservableObject {
    @Published var notes: [DriverNote] = []
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var successMessage: String?
    @Published var errorMessage: String?

    private let key = "nurseryconnect_macos_driver_notes"

    init() {
        loadNotes()
    }

    var pinnedNotes: [DriverNote] {
        notes.filter { $0.isPinned }.sorted { $0.createdAt > $1.createdAt }
    }

    var normalNotes: [DriverNote] {
        notes.filter { !$0.isPinned }.sorted { $0.createdAt > $1.createdAt }
    }

    func addNote() {
        guard !title.isBlank else {
            errorMessage = "Please enter a note title."
            return
        }

        guard !message.isBlank else {
            errorMessage = "Please enter a note message."
            return
        }

        let note = DriverNote(
            title: title.trimmedText,
            message: message.trimmedText
        )

        withAnimation(.spring()) {
            notes.insert(note, at: 0)
        }

        saveNotes()
        resetForm()
        successMessage = "Driver note added."
    }

    func togglePin(_ note: DriverNote) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }

        withAnimation(.easeInOut) {
            notes[index].isPinned.toggle()
        }

        saveNotes()
    }

    func deleteNote(_ note: DriverNote) {
        withAnimation(.easeInOut) {
            notes.removeAll { $0.id == note.id }
        }

        saveNotes()
        successMessage = "Driver note deleted."
    }

    func resetForm() {
        title = ""
        message = ""
    }

    private func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            errorMessage = "Failed to save driver notes."
        }
    }

    private func loadNotes() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            notes = sampleNotes
            return
        }

        do {
            notes = try JSONDecoder().decode([DriverNote].self, from: data)
        } catch {
            notes = sampleNotes
            errorMessage = "Failed to load driver notes."
        }
    }

    private var sampleNotes: [DriverNote] {
        [
            DriverNote(
                title: "Check school gate timing",
                message: "Little Stars Preschool usually opens the gate after 3:10 PM.",
                isPinned: true
            ),
            DriverNote(
                title: "Roadwork near Main Road",
                message: "Allow extra time when travelling to Sunshine Kids School."
            )
        ]
    }
}
