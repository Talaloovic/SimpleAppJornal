import SwiftUI

struct AddEntryView: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showAlert: Bool = false
    var journalStore: JournalStore
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            Button(action: addEntry) {
                Text("Save Entry")
            }
        }
        .navigationBarTitle("Add New Entry")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text("All fields should be filled to save the entry."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func addEntry() {
        if title.isEmpty || content.isEmpty {
 
            showAlert = true
        } else {
 
            journalStore.addEntry(title: title, content: content)
            presentationMode.wrappedValue.dismiss() 
        }
    }
}
