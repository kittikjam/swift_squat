import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            Text("Train")
                .tabItem {
                    Label("Train", systemImage: "figure.strengthtraining.traditional")
                }

            Text("Progress")
                .tabItem {
                    Label("Progress", systemImage: "chart.xyaxis.line")
                }

            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .toolbarBackground(Visibility.visible, for: ToolbarPlacement.tabBar)
        .toolbarBackground(AppTheme.canvas, for: ToolbarPlacement.tabBar)
    }
}