//
//  ContentView.swift
//  IntegrationApp
//
//  Created by Khoa Le on 15/03/2023.
//

import SwiftUI
import DesignSystem
import Authentication

struct ContentView: View {
    var body: some View {
        AuthenticationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
