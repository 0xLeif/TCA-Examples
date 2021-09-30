//
//  PaymentExampleApp.swift
//  Shared
//
//  Created by Leif on 9/29/21.
//

import ComposableArchitecture
import SwiftUI

struct AppState: Equatable {
    var paymentToState: PaymentAccountState
    var paymentFromState: PaymentAccountState
}

enum AppAction {
    case paymentTo(PaymentAccountAction)
    case paymentFrom(PaymentAccountAction)
}

let appReducer = Reducer<AppState, AppAction, Void>.combine(
    paymentAccountReducer
        .pullback(
            state: \.paymentToState,
            action: /AppAction.paymentTo,
            environment: { _ in
                PaymentAccountEnvironment(
                    fetchAccounts: {
                        Effect(value: .fetchAccountsResponse(accounts: ["Leif", "Jim"]))
                    }
                )
            }
        ),
    paymentAccountReducer
        .pullback(
            state: \.paymentFromState,
            action: /AppAction.paymentFrom,
            environment: { _ in
                PaymentAccountEnvironment(
                    fetchAccounts: {
                        Effect(value: .fetchAccountsResponse(accounts: ["Joe", "Xono", "Trey (Default)"]))
                    }
                )
            }
        )
)

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                NavigationLink(
                    destination: {
                        PaymentToView(
                            store: store.scope(state: \.paymentToState, action: AppAction.paymentTo)
                        )
                    },
                    label: {
                        HStack {
                            Text("To")
                            Spacer()
                            IfLetStore(store.scope(state: \.paymentToState.selectedAccount)) { ifLetStore in
                                WithViewStore(ifLetStore) { ifLetViewStore in
                                    Text(ifLetViewStore.state)
                                }
                            }
                        }
                    }
                )
                NavigationLink(
                    destination: {
                        PaymentToView(
                            store: store.scope(state: \.paymentFromState, action: AppAction.paymentFrom)
                        )
                    },
                    label: {
                        HStack {
                            Text("From")
                            Spacer()
                            IfLetStore(store.scope(state: \.paymentFromState.selectedAccount)) { ifLetStore in
                                WithViewStore(ifLetStore) { ifLetViewStore in
                                    Text(ifLetViewStore.state)
                                }
                            }
                        }
                    }
                )
            }
            .navigationTitle(Text("Make a Payment"))
        }
    }
}

@main
struct PaymentExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView(
                    store: Store(
                        initialState: AppState(
                            paymentToState: PaymentAccountState(
                                selectedAccount: nil,
                                accounts: []
                            ),
                            paymentFromState: PaymentAccountState(
                                selectedAccount: "Trey (Default)",
                                accounts: ["Trey (Default)"]
                            )
                        ),
                        reducer: appReducer,
                        environment: ()
                    )
                )
            }
        }
    }
}
