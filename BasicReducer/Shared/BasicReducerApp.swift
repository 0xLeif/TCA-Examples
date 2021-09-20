//
//  BasicReducerApp.swift
//  Shared
//
//  Created by Leif on 9/20/21.
//

import SwiftUI
import ComposableArchitecture

struct AppState: Equatable {
    var text: String
}

enum AppAction {
    case didAppear
    case update(text: String)
}

struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .didAppear:
        return Effect(value: .update(text: "Did Appear"))
            .delay(for: 1, scheduler: environment.mainQueue)
            .eraseToEffect()
    case .update(let text):
        state.text = text
        return .none
    }
}

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text(viewStore.text)
                .padding()
                .onAppear {
                    viewStore.send(.didAppear)
                }
        }
    }
}

@main
struct BasicReducerApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(
                        text: "Initial"
                    ),
                    reducer: appReducer,
                    environment: AppEnvironment(
                        mainQueue: .main
                    )
                )
            )
        }
    }
}
