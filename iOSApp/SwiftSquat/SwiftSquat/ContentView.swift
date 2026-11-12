import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.system(size: 48))

            Text("Swift Squat")
                .font(.largeTitle.bold())

            Button("Start workout") {
                print("Workout started")
            }
        }
        .padding(40)
    }
}

#Preview {
    ContentView()
}
