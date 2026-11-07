import SwiftUI

// MARK: - Storage keys
enum StorageKeys {
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let email = "email"
    static let isLoggedIn = "isLoggedIn"
}

// MARK: - Brand colors
extension Color {
    static let llGreen = Color(red: 42 / 255, green: 71 / 255, blue: 62 / 255)   // #2A473E
    static let llYellow = Color(red: 244 / 255, green: 206 / 255, blue: 20 / 255) // #F4CE14
    static let llCream = Color(red: 237 / 255, green: 239 / 255, blue: 238 / 255) // #EDEFEE
}

// MARK: - Menu category
enum MenuCategory: String, CaseIterable, Identifiable {
    case starters = "Starters"
    case mains = "Mains"
    case desserts = "Desserts"
    case drinks = "Drinks"

    var id: String { rawValue }
}

// MARK: - Menu item
struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let price: Double
    let category: MenuCategory
    let description: String
    let symbol: String
    let tint: Color

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }
}

// MARK: - Sample data
extension MenuItem {
    static let sampleMenu: [MenuItem] = [
        // Starters
        MenuItem(title: "Greek Salad", price: 10.00, category: .starters,
                 description: "Crisp lettuce, peppers, olives and feta cheese.",
                 symbol: "leaf.fill", tint: .green),
        MenuItem(title: "Bruschetta", price: 7.50, category: .starters,
                 description: "Grilled bread with garlic, tomato and olive oil.",
                 symbol: "fork.knife", tint: .orange),
        MenuItem(title: "Hummus Plate", price: 8.25, category: .starters,
                 description: "Creamy hummus served with warm pita.",
                 symbol: "circle.grid.2x2.fill", tint: .brown),
        MenuItem(title: "Caesar Salad", price: 9.50, category: .starters,
                 description: "Romaine, parmesan, croutons and Caesar dressing.",
                 symbol: "leaf.fill", tint: .mint),

        // Mains
        MenuItem(title: "Lemon Chicken", price: 18.00, category: .mains,
                 description: "Roasted chicken with lemon and herbs.",
                 symbol: "flame.fill", tint: .yellow),
        MenuItem(title: "Grilled Fish", price: 20.00, category: .mains,
                 description: "Fresh catch grilled with Mediterranean spices.",
                 symbol: "fish.fill", tint: .blue),
        MenuItem(title: "Pasta Primavera", price: 15.50, category: .mains,
                 description: "Penne with seasonal vegetables in olive oil.",
                 symbol: "fork.knife.circle.fill", tint: .red),
        MenuItem(title: "Veggie Salad Bowl", price: 13.00, category: .mains,
                 description: "Quinoa, roasted vegetables and tahini dressing.",
                 symbol: "carrot.fill", tint: .orange),

        // Desserts
        MenuItem(title: "Lemon Dessert", price: 6.99, category: .desserts,
                 description: "Traditional homemade lemon cake.",
                 symbol: "birthday.cake.fill", tint: .yellow),
        MenuItem(title: "Baklava", price: 5.99, category: .desserts,
                 description: "Layered pastry with nuts and honey.",
                 symbol: "square.stack.3d.up.fill", tint: .brown),
        MenuItem(title: "Gelato", price: 4.50, category: .desserts,
                 description: "Two scoops of house-made gelato.",
                 symbol: "snowflake", tint: .pink),

        // Drinks
        MenuItem(title: "Fresh Lemonade", price: 3.50, category: .drinks,
                 description: "Squeezed lemons with a hint of mint.",
                 symbol: "cup.and.saucer.fill", tint: .yellow),
        MenuItem(title: "Iced Tea", price: 3.00, category: .drinks,
                 description: "Black tea served over ice with lemon.",
                 symbol: "mug.fill", tint: .brown),
        MenuItem(title: "Sparkling Water", price: 2.50, category: .drinks,
                 description: "Chilled mineral water with bubbles.",
                 symbol: "drop.fill", tint: .cyan),
        MenuItem(title: "Espresso", price: 2.75, category: .drinks,
                 description: "Rich, strong Italian-style espresso.",
                 symbol: "cup.and.saucer.fill", tint: .brown)
    ]
}