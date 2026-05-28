import Foundation
import LocalAuthentication

protocol LocalAuthenticationServiceProtocol {
    func authenticate(reason: String) async -> Bool
    func biometricType() -> String
}

final class LocalAuthenticationService: LocalAuthenticationServiceProtocol {

    func authenticate(reason: String) async -> Bool {
        let context = LAContext()
        var error: NSError?

        let canEvaluate = context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        )

        guard canEvaluate else {
            return false
        }

        do {
            return try await context.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: reason
            )
        } catch {
            return false
        }
    }

    func biometricType() -> String {
        let context = LAContext()
        var error: NSError?

        _ = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )

        switch context.biometryType {
        case .touchID:
            return "Touch ID"
        case .faceID:
            return "Face ID"
        case .opticID:
            return "Optic ID"
        default:
            return "Device Password"
        }
    }
}
