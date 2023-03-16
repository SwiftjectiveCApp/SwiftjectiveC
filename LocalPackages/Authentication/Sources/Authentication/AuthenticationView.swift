import DesignSystem
import SwiftUI

public struct AuthenticationView: View {
    public init(delegate: AuthenticationDelegate) {
        viewModel.delegate = delegate
    }

    @ObservedObject private var viewModel: AuthenticationViewModel = .init()
    @State private var showLoginAlertField = false
    @State private var accessToken = ""
    
    public var body: some View {
        VStack {
            Text("Welcome to IntegrationApp")

            DSButton("Sign in with GitHub Access Token", icon: .sfSymbol("paperplane", weight: .medium)) {
                showLoginAlertField.toggle()
            }
        }
        .padding()
        .alert("Personal Access Token", isPresented: $showLoginAlertField) {
            SecureField("Personal Access Token", text: $accessToken)
                .font(.callout)

            Button("Login") {
                let token = accessToken
                Task {
                    await viewModel.loginWithToken("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")
                }
                accessToken = ""
            }

            Button("Cancel", role: .cancel) {
                accessToken = ""
            }
        } message: {
            Text("Sign in with a Personal Access Token with both gists and user scopes.")
        }
    }
}
