import SwiftUI

struct DriverNotesListView: View {
    @EnvironmentObject var driverNotesViewModel: DriverNotesViewModel

    @State private var showEditor = false

    var body: some View {
        HStack(spacing: 22) {
            VStack(alignment: .leading, spacing: 18) {
                header

                if driverNotesViewModel.notes.isEmpty {
                    EmptyStateView(
                        title: "No Driver Notes",
                        message: "Create notes for route reminders, school gate instructions, or transport observations.",
                        systemImage: "note.text"
                    )
                } else {
                    List {
                        if !driverNotesViewModel.pinnedNotes.isEmpty {
                            Section("Pinned") {
                                ForEach(driverNotesViewModel.pinnedNotes) { note in
                                    noteRow(note)
                                }
                            }
                        }

                        Section("All Notes") {
                            ForEach(driverNotesViewModel.normalNotes) { note in
                                noteRow(note)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
            .frame(minWidth: 520)

            DriverNoteEditorView()
                .frame(maxWidth: .infinity)
        }
        .padding(28)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Driver Notes")
                    .font(.largeTitle.bold())

                Text("Keep route reminders and operational notes for the transport workflow.")
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    private func noteRow(_ note: DriverNote) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(note.title)
                    .font(.headline)

                Spacer()

                Button {
                    driverNotesViewModel.togglePin(note)
                } label: {
                    Image(systemName: note.isPinned ? "pin.fill" : "pin")
                }
                .buttonStyle(.plain)

                Button {
                    driverNotesViewModel.deleteNote(note)
                } label: {
                    Image(systemName: "trash")
                }
                .buttonStyle(.plain)
            }

            Text(note.message)
                .foregroundStyle(.secondary)

            Text(DateFormatterHelper.displayDateTime(note.createdAt))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
