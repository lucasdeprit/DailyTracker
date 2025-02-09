import SwiftUI
import SwiftData

@main
struct DailyTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ReminderListView()
        }
        .modelContainer(for: Reminder.self)
    }
}
