import SwiftUI
import ComposableArchitecture

struct CounterState: Equatable {
    var count: Int
}

enum CounterAction {
    case increment
    case decrement
}

let counterReducer = Reducer<CounterState, CounterAction, Void> { state, action, _ in
    switch action {
    case .increment:
        state.count += 1
        return .none
        
    case .decrement:
        state.count -= 1
        return .none
    }
}

struct CounterView: View {
    var store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.title)
                    .padding()
                
                HStack {
                    Button("-", action: {viewStore.send(.decrement)})
                        .font(.title)
                    Spacer()
                    Button("+", action: {viewStore.send(.increment)})
                        .font(.title)
                }
                .padding()
            }
        }
    }
}
