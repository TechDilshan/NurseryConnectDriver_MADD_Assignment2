import SwiftUI

struct MacSidebarView: View {
    @EnvironmentObject var navigationViewModel: MacNavigationViewModel

    var body: some View {
        List(selection: $navigationViewModel.selectedSidebarItem) {
            Section("Operations") {
                sidebarRow(.dashboard)
                sidebarRow(.liveRoute)
                sidebarRow(.manifest)
            }

            Section("Safety") {
                sidebarRow(.incidents)
                sidebarRow(.reports)
            }

            Section("Insights") {
                sidebarRow(.analytics)
                sidebarRow(.notes)
            }

            Section("System") {
                sidebarRow(.settings)
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("NurseryConnect")
        .frame(minWidth: 230)
    }

    private func sidebarRow(_ item: SidebarSelection) -> some View {
        Label(item.title, systemImage: item.systemImage)
            .tag(item)
            .font(.system(size: 14, weight: .medium))
    }
}
