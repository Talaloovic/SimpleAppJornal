
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {

            HomeView()
        } else {
          
            VStack {
                Text("My Journal App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .onAppear {
                // Start a timer to show splash screen for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
