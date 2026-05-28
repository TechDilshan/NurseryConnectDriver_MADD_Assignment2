import SwiftUI

struct MacManifestView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    @State private var selectedChildID: String?

    var selectedChild: Child? {
        guard let selectedChildID else { return nil }
        return transportViewModel.child(withID: selectedChildID)
    }

    var body: some View {
        HStack(spacing: 22) {
            VStack(alignment: .leading, spacing: 18) {
                header

                TextField("Search by child, school, or pickup point", text: $transportViewModel.searchText)
                    .textFieldStyle(.roundedBorder)

                List(selection: $selectedChildID) {
                    ForEach(transportViewModel.filteredChildren) { child in
                        ChildRowView(child: child)
                            .tag(child.id)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .frame(minWidth: 430)

            if let selectedChild {
                MacChildDetailPanel(child: selectedChild)
                    .frame(maxWidth: .infinity)
            } else {
                EmptyStateView(
                    title: "Select a Child",
                    message: "Choose a child from the manifest to view transport details and update pickup status.",
                    systemImage: "person.text.rectangle.fill"
                )
                .frame(maxWidth: .infinity)
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 22))
            }
        }
        .padding(28)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today’s Manifest")
                .font(.largeTitle.bold())

            Text("View assigned children, pickup locations, and transport status.")
                .foregroundStyle(.secondary)
        }
    }
}
