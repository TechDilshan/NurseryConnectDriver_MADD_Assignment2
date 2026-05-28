import SwiftUI

struct SecureAccessView<Content: View>: View {
    @StateObject private var securityViewModel = SecurityViewModel()

    let title: String
    let subtitle: String
    let systemImage: String
    let content: () -> Content

    init(
        title: String = "Secure Area",
        subtitle: String = "This section contains sensitive child transport and safeguarding information.",
        systemImage: String = "lock.shield.fill",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.content = content
    }

    var body: some View {
        Group {
            if securityViewModel.isUnlocked {
                content()
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                securityViewModel.lock()
                            } label: {
                                Label("Lock", systemImage: "lock.fill")
                            }
                        }
                    }
            } else {
                lockedView
            }
        }
    }

    private var lockedView: some View {
        VStack(spacing: 22) {
            Image(systemName: systemImage)
                .font(.system(size: 64))
                .foregroundStyle(.blue)

            VStack(spacing: 8) {
                Text(title)
                    .font(.largeTitle.bold())

                Text(subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 520)
            }

            Button {
                securityViewModel.authenticate()
            } label: {
                Label("Unlock with \(securityViewModel.biometricType)", systemImage: "touchid")
                    .font(.headline)
                    .frame(width: 280)
            }
            .buttonStyle(.borderedProminent)
            .disabled(securityViewModel.isAuthenticating)

            if securityViewModel.isAuthenticating {
                ProgressView("Authenticating...")
            }

            if let errorMessage = securityViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
            }

            Text("This is not a login screen. It is a local macOS security check for sensitive records only.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 520)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
        .background(Color.appGroupedBackground)
    }
}
