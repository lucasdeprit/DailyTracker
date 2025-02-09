import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var reminders: [Reminder]

    @State private var isShowingAddReminder = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(reminders) { reminder in
                    HStack {
                        Button(action: {
                            reminder.isCompleted.toggle()
                        }) {
                            Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(reminder.isCompleted ? .green : .gray)
                        }
                        .buttonStyle(.plain)

                        VStack(alignment: .leading) {
                            Text(reminder.title)
                                .strikethrough(reminder.isCompleted, color: .gray)
                            if let dueDate = reminder.dueDate {
                                Text(dueDate, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Recordatorios")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isShowingAddReminder = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddReminder) {
                AddReminderView(isPresented: $isShowingAddReminder)
                    .presentationDetents([.medium]) // Define el tamaño del popup
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(reminders[index])
        }
    }
}
