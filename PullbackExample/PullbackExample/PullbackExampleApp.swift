import SwiftUI
import ComposableArchitecture

@main
struct PullbackExampleApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootState(
                        colorState: ColorState(red: 0, green: 0, blue: 0),
                        counterState: CounterState(count: 0)
                    ),
                    reducer: rootReducer,
                    environment: ()
                )
            )
        }
    }
}
