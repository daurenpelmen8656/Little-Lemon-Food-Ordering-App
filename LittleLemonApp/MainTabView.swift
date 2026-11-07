import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .accentColor(.llGreen)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}