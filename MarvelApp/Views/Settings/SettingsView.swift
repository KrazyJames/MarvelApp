//
//  SettingsView.swift
//  MarvelApp
//
//  Created by jescobar on 7/11/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var isPresented = false
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Cell")
                }
                .searchable(text: .constant(""))
            }
            .toolbar {
                ToolbarItem.init(placement: .primaryAction) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        SwiftUI.Image(systemName: "person.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(Circle())
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $isPresented) {
                EmptyView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
