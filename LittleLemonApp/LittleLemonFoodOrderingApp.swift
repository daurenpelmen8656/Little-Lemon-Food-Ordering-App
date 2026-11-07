import SwiftUI

@main
struct LittleLemonFoodOrderingApp: App {
    @AppStorage(StorageKeys.isLoggedIn) private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}