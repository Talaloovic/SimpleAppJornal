import SwiftUI

struct HomeView: View {
    @ObservedObject var journalStore = JournalStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(journalStore.entries) { entry in
                    NavigationLink(destination: EditEntryView(entry: entry, journalStore: journalStore)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Text(entry.content)
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                                .truncationMode(.tail)
                            
                            Text(entry.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Journal Entries", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: AddEntryView(journalStore: journalStore)) {
                HStack {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            })
            .padding(.top, 10)
        }
    }
    
    func deleteEntry(at offsets: IndexSet) {
        journalStore.deleteEntry(at: offsets)
    }
}

