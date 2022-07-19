//
//  View+Extensions.swift
//  MarvelApp
//
//  Created by jescobar on 7/6/22.
//

import SwiftUI

extension View {
    public func onSubmit(
        of triggers: SubmitTriggers = .text,
        _ action: @escaping @Sendable () async -> Void
    ) -> some View {
        return self.onSubmit(
            of: triggers
        ) {
            Task {
                await action()
            }
        }
    }

    public func clearListRow() -> some View {
        self
            .listRowInsets(.init())
            .listRowBackground(Color.clear)
    }
}
