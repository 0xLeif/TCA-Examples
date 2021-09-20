import SwiftUI
import ComposableArchitecture

struct ColorState: Equatable {
    var red: Double
    var green: Double
    var blue: Double
}

enum ColorAction {
    case red(value: Double)
    case green(value: Double)
    case blue(value: Double)
}

let colorReducer = Reducer<ColorState, ColorAction, Void> { state, action, _ in
    switch action {
    case .red(let value):
        state.red = value
        return .none
        
    case .green(let value):
        state.green = value
        return .none
        
    case .blue(let value):
        state.blue = value
        return .none
    }
}

struct ColorView: View {
    var store: Store<ColorState, ColorAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Color(
                    red: viewStore.red,
                    green: viewStore.green,
                    blue: viewStore.blue,
                    opacity: 1
                )
                
                Slider(
                    value: viewStore.binding(
                        get: \.red,
                        send: { ColorAction.red(value: $0) }
                    ),
                    in: 0 ... 1
                )
                
                Slider(
                    value: viewStore.binding(
                        get: \.green,
                        send: { ColorAction.green(value: $0) }
                    ),
                    in: 0 ... 1
                )
                
                Slider(
                    value: viewStore.binding(
                        get: \.blue,
                        send: { ColorAction.blue(value: $0) }
                    ),
                    in: 0 ... 1
                )
            }
        }
    }
}
