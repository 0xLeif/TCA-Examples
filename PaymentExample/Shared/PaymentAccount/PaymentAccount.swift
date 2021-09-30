//
//  PaymentAccount.swift
//  PaymentExample
//
//  Created by Leif on 9/29/21.
//

import ComposableArchitecture

struct PaymentAccountState: Equatable {
    var selectedAccount: String?
    
    var accounts: [String]
}

enum PaymentAccountAction {
    case select(account: String)
    
    case fetchAccounts
    case fetchAccountsResponse(accounts: [String])
}

struct PaymentAccountEnvironment {
    var fetchAccounts: () -> Effect<PaymentAccountAction, Never>
}

let paymentAccountReducer = Reducer<PaymentAccountState, PaymentAccountAction, PaymentAccountEnvironment> { state, action, environment in
    switch action {
        
    case .select(account: let account):
        state.selectedAccount = account
        return .none
        
    case .fetchAccounts:
        return environment.fetchAccounts()
        
    case .fetchAccountsResponse(accounts: let accounts):
        state.accounts = accounts
        return .none
    }
}
