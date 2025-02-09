import SwiftUI
import SwiftData

struct AddReminderView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool

    @State private var title: String = ""
    @State private var dueDate: Date = Date()
    @State private var hasDueDate: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Título")) {
                    TextField("Escribe un recordatorio...", text: $title)
                }

                Section {
                    Toggle("Agregar fecha", isOn: $hasDueDate)
                    if hasDueDate {
                        DatePicker("Fecha", selection: $dueDate, displayedComponents: .date)
                    }
                }

                Section {
                    Button("Guardar") {
                        addReminder()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("Nuevo Recordatorio")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                }
            }
        }
    }

    private func addReminder() {
        let newReminder = Reminder(title: title, dueDate: hasDueDate ? dueDate : nil)
        modelContext.insert(newReminder)
        isPresented = false
    }
}
