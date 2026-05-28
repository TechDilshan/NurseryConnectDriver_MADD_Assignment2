import SwiftUI

struct DriverNoteEditorView: View {
    @EnvironmentObject var driverNotesViewModel: DriverNotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SectionHeaderView(
                title: "Create Note",
                subtitle: "Add a reminder or transport observation"
            )

            TextField("Note title", text: $driverNotesViewModel.title)
                .textFieldStyle(.roundedBorder)

            TextEditor(text: $driverNotesViewModel.message)
                .frame(minHeight: 180)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                }

            Button {
                driverNotesViewModel.addNote()
            } label: {
                PrimaryButton(title: "Save Note", systemImage: "note.text.badge.plus", color: .blue)
            }

            if let success = driverNotesViewModel.successMessage {
                Text(success)
                    .foregroundStyle(.green)
            }

            if let error = driverNotesViewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }

            Spacer()
        }
        .padding(28)
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
