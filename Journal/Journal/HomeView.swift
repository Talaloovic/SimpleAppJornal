

import SwiftUI

struct HomeView: View {
    @ObservedObject var journalStore = JournalStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(journalStore.entries) { entry in
                    NavigationLink(destination: EditEntryView(entry: entry, journalStore: journalStore)) {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.content)
                                .lineLimit(2)
                                .font(.subheadline)
                            Text(entry.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationBarTitle("Journal Entries")
            .navigationBarItems(trailing: NavigationLink("Add", destination: AddEntryView(journalStore: journalStore)))
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        journalStore.deleteEntry(at: offsets)
    }
}
