

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(JournalStore())
    }
}

