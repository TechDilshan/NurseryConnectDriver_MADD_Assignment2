import Foundation
import SwiftUI

@MainActor
final class SecurityViewModel: ObservableObject {
    @Published var isUnlocked: Bool = false
    @Published var isAuthenticating: Bool = false
    @Published var errorMessage: String?

    private let authenticationService: LocalAuthenticationServiceProtocol

    init(authenticationService: LocalAuthenticationServiceProtocol = LocalAuthenticationService()) {
        self.authenticationService = authenticationService
    }

    var biometricType: String {
        authenticationService.biometricType()
    }

    func authenticate() {
        isAuthenticating = true
        errorMessage = nil

        Task {
            let success = await authenticationService.authenticate(
                reason: "Unlock sensitive NurseryConnect transport records."
            )

            await MainActor.run {
                self.isUnlocked = success
                self.isAuthenticating = false

                if !success {
                    self.errorMessage = "Authentication failed. Please try again."
                }
            }
        }
    }

    func lock() {
        isUnlocked = false
        errorMessage = nil
    }
}
