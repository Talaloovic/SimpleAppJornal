

import Foundation

class JournalStore: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    func addEntry(title: String, content: String) {
        let newEntry = JournalEntry(title: title, content: content, date: Date())
        entries.append(newEntry)
    }
    
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
    
    func updateEntry(id: UUID, newTitle: String, newContent: String) {
        if let index = entries.firstIndex(where: { $0.id == id }) {
            entries[index].title = newTitle
            entries[index].content = newContent
        }
    }
}
