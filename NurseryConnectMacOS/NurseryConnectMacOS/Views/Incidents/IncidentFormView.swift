import SwiftUI

struct IncidentFormView: View {
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Child and Incident Type") {
                    TextField("Child name", text: $incidentViewModel.childName)

                    Picker("Incident Type", selection: $incidentViewModel.selectedType) {
                        ForEach(IncidentType.allCases, id: \.self) { type in
                            Label(type.title, systemImage: type.systemImage).tag(type)
                        }
                    }

                    Picker("Severity", selection: $incidentViewModel.selectedSeverity) {
                        ForEach(IncidentSeverity.allCases, id: \.self) { severity in
                            Text(severity.title).tag(severity)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Incident Details") {
                    TextField("Location", text: $incidentViewModel.location)

                    TextEditor(text: $incidentViewModel.incidentDescription)
                        .frame(minHeight: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        }

                    TextEditor(text: $incidentViewModel.actionTaken)
                        .frame(minHeight: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        }
                }

                Section("Safeguarding Note") {
                    Text("This MVP records transport safety events locally. A production NurseryConnect system would store incident records in a secure audit log and notify the Setting Manager where required.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("New Incident Report")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        incidentViewModel.resetForm()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        incidentViewModel.addIncident()

                        if incidentViewModel.errorMessage == nil {
                            dismiss()
                        }
                    }
                }
            }
            .alert("Notice", isPresented: Binding(
                get: { incidentViewModel.errorMessage != nil },
                set: { if !$0 { incidentViewModel.clearMessages() } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(incidentViewModel.errorMessage ?? "")
            }
        }
    }
}
