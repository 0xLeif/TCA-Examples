import SwiftUI
import ComposableArchitecture

struct RootState: Equatable {
    var colorState: ColorState
    var counterState: CounterState
}

enum RootAction {
    case color(action: ColorAction)
    case counter(action: CounterAction)
}

let rootReducer = Reducer<RootState, RootAction, Void>.combine(
    colorReducer
        .pullback(
            state: \.colorState,
            action: /RootAction.color,
            environment: { }
        ),
    counterReducer
        .pullback(
            state: \.counterState,
            action: /RootAction.counter,
            environment: { }
        )
)

struct RootView: View {
    let store: Store<RootState, RootAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                ColorView(
                    store: self.store.scope(
                        state: \.colorState,
                        action: RootAction.color
                    )
                )
                
                CounterView(
                    store: self.store.scope(
                        state: \.counterState,
                        action: RootAction.counter
                    )
                )
            }
        }
    }
}
