import SwiftUI

struct EditEntryView: View {
    @State private var title: String
    @State private var content: String
    var entry: JournalEntry
    var journalStore: JournalStore
    @Environment(\.presentationMode) var presentationMode

    init(entry: JournalEntry, journalStore: JournalStore) {
        _title = State(initialValue: entry.title)
        _content = State(initialValue: entry.content)
        self.entry = entry
        self.journalStore = journalStore
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title").font(.headline).foregroundColor(.primary)) {
                    TextField("Enter title", text: $title)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                }
                
                Section(header: Text("Content").font(.headline).foregroundColor(.primary)) {
                    TextEditor(text: $content)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .font(.body)
                        .frame(height: 200)
                }
                
                Button(action: updateEntry) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(title.isEmpty || content.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .font(.title3)
                        .padding(.top)
                }
                .disabled(title.isEmpty || content.isEmpty)
            }
            .navigationBarTitle("Edit Entry", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: .constant(title.isEmpty || content.isEmpty)) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Both title and content must be filled in to save changes."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .accentColor(.blue)
    }
    
    func updateEntry() {
        // Save changes to the journal store
        journalStore.updateEntry(id: entry.id, newTitle: title, newContent: content)
        presentationMode.wrappedValue.dismiss()
    }
}

