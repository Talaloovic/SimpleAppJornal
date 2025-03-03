

import SwiftUI

struct EditEntryView: View {
    @State private var title: String
    @State private var content: String
    var entry: JournalEntry
    var journalStore: JournalStore
    
    init(entry: JournalEntry, journalStore: JournalStore) {
        _title = State(initialValue: entry.title)
        _content = State(initialValue: entry.content)
        self.entry = entry
        self.journalStore = journalStore
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            Button(action: updateEntry) {
                Text("Save Changes")
            }
        }
        .navigationBarTitle("Edit Entry")
    }
    
    func updateEntry() {
        journalStore.updateEntry(id: entry.id, newTitle: title, newContent: content)
    }
}
