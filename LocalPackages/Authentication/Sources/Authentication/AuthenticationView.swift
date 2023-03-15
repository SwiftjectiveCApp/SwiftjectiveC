import DesignSystem
import SwiftUI

public struct AuthenticationView: View {
    public init() {}

    @StateObject private var viewModel: AuthenticationViewModel = .init()
    
    public var body: some View {
        VStack {
            Text("Welcome to IntegrationApp")

            DSButton("Sign in with GitHub Access Token", icon: .sfSymbol("paperplane", weight: .medium)) {
                print("aoeu")
            }
        }
        .padding()
    }
}
