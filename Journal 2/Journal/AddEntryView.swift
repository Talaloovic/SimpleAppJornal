import SwiftUI

struct AddEntryView: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showAlert: Bool = false
    var journalStore: JournalStore
    @Environment(\.presentationMode) var presentationMode

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
                        .frame(height: 200)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .font(.body)
                }
                
                Button(action: addEntry) {
                    Text("Save Entry")
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
            .navigationBarTitle("Add New Entry", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("All fields should be filled to save the entry."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .accentColor(.blue)
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
