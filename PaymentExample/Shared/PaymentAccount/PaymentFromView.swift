//
//  PaymentFromView.swift
//  PaymentExample
//
//  Created by Leif on 9/29/21.
//

import ComposableArchitecture
import SwiftUI

struct PaymentFromView: View {
    let store: Store<PaymentAccountState, PaymentAccountAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Section(
                    content: {
                        List(viewStore.accounts, id: \.self) { account in
                            Button(
                                action: {
                                    viewStore.send(.select(account: account))
                                },
                                label: {
                                    HStack {
                                        Text(account)
                                        Spacer()
                                        if account == viewStore.selectedAccount {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            )
                        }
                    },
                    header: {
                        Text("Select an account to pay from")
                    }
                )
            }
            .onAppear {
                viewStore.send(.fetchAccounts)
            }
        }
    }
}


struct PaymentFromViewPreview: PreviewProvider {
    static var previews: some View {
        PaymentFromView(
            store: Store(
                initialState: .init(
                    selectedAccount: "Jim",
                    accounts: ["Jim"]
                ),
                reducer: paymentAccountReducer,
                environment: PaymentAccountEnvironment(
                    fetchAccounts: {
                        Effect(
                            value: .fetchAccountsResponse(
                                accounts: ["Leif", "Jim"]
                            )
                        )
                    }
                )
            )
        )
    }
}
