import SwiftUI

struct MenuView: View {
    @State private var searchText = ""
    @State private var selectedCategory: MenuCategory? = nil

    private let allItems = MenuItem.sampleMenu

    // Applies the category filter first, then the case-insensitive search.
    private var filteredItems: [MenuItem] {
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        return allItems.filter { item in
            let matchesCategory = selectedCategory == nil || item.category == selectedCategory
            let matchesSearch = trimmedSearch.isEmpty
                || item.title.localizedCaseInsensitiveContains(trimmedSearch)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                heroSection
                categoryBar
                menuList
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }

    // MARK: - Hero
    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Little Lemon")
                .font(.system(size: 40, weight: .bold, design: .serif))
                .foregroundColor(.llYellow)

            Text("Chicago")
                .font(.system(size: 24, weight: .medium, design: .serif))
                .foregroundColor(.white)

            HStack(alignment: .top, spacing: 12) {
                Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.body)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)

                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.llYellow)
            }

            searchBar
                .padding(.top, 6)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.llGreen)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search menu", text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.black)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }

    // MARK: - Category bar
    private var categoryBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ORDER FOR DELIVERY!")
                .font(.system(size: 16, weight: .heavy))
                .foregroundColor(.llGreen)
                .padding(.horizontal, 20)
                .padding(.top, 12)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(MenuCategory.allCases) { category in
                        categoryButton(category)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }

    private func categoryButton(_ category: MenuCategory) -> some View {
        let isSelected = selectedCategory == category

        return Button {
            // Tapping the selected category again clears the filter.
            selectedCategory = isSelected ? nil : category
        } label: {
            Text(category.rawValue)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(isSelected ? .white : .llGreen)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.llGreen : Color.llCream)
                .cornerRadius(16)
        }
    }

    // MARK: - Menu list
    private var menuList: some View {
        Group {
            if filteredItems.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("No dishes found")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                List(filteredItems) { item in
                    MenuRow(item: item)
                        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                }
                .listStyle(.plain)
            }
        }
    }
}

// MARK: - Row
struct MenuRow: View {
    let item: MenuItem

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)

                Text(item.description)
                    .font(.system(size: 14))
                    .foregroundColor(.llGreen)
                    .lineLimit(2)

                Text(item.formattedPrice)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.llGreen)
            }

            Spacer()

            // Placeholder image (SF Symbol on a colored rounded rectangle)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(item.tint.opacity(0.25))
                Image(systemName: item.symbol)
                    .font(.system(size: 30))
                    .foregroundColor(item.tint)
            }
            .frame(width: 80, height: 80)
        }
        .padding(.vertical, 4)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}