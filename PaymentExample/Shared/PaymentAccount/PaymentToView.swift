//
//  PaymentToView.swift
//  PaymentExample
//
//  Created by Leif on 9/29/21.
//

import ComposableArchitecture
import SwiftUI

struct PaymentToView: View {
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
                        Text("Select an account to pay")
                    }
                )
            }
            .onAppear {
                viewStore.send(.fetchAccounts)
            }
        }
    }
}


struct PaymentToViewPreview: PreviewProvider {
    static var previews: some View {
        PaymentToView(
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
