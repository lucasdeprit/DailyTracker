import SwiftData
import Foundation

@Model
class Reminder {
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    
    init(title: String,
         isCompleted: Bool = false,
         dueDate: Date? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}
