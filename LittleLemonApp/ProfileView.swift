import SwiftUI

struct ProfileView: View {
    @AppStorage(StorageKeys.firstName) private var firstName: String = ""
    @AppStorage(StorageKeys.lastName) private var lastName: String = ""
    @AppStorage(StorageKeys.email) private var email: String = ""
    @AppStorage(StorageKeys.isLoggedIn) private var isLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            header

            VStack(alignment: .leading, spacing: 20) {
                Text("Personal information")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(.llGreen)

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.llGreen)
                    .frame(maxWidth: .infinity)

                infoField(label: "First name", value: firstName)
                infoField(label: "Last name", value: lastName)
                infoField(label: "Email", value: email)

                Spacer()

                Button(action: logout) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.llGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.llYellow)
                        .cornerRadius(10)
                }
            }
            .padding(20)
        }
        .background(Color.white.ignoresSafeArea())
    }

    private var header: some View {
        Text("Little Lemon")
            .font(.system(size: 32, weight: .bold, design: .serif))
            .foregroundColor(.llYellow)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.llGreen)
    }

    private func infoField(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.llGreen.opacity(0.4), lineWidth: 1)
                )
        }
    }

    private func logout() {
        firstName = ""
        lastName = ""
        email = ""
        isLoggedIn = false
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}