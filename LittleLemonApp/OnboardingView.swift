import SwiftUI

struct OnboardingView: View {
    @AppStorage(StorageKeys.firstName) private var firstName: String = ""
    @AppStorage(StorageKeys.lastName) private var lastName: String = ""
    @AppStorage(StorageKeys.email) private var email: String = ""
    @AppStorage(StorageKeys.isLoggedIn) private var isLoggedIn: Bool = false

    @State private var currentPage = 0

    // MARK: - Validation
    private var isFirstNameValid: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var isLastNameValid: Bool {
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var isEmailValid: Bool {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return trimmed.range(of: pattern, options: .regularExpression) != nil
    }

    private var isCurrentPageValid: Bool {
        switch currentPage {
        case 0: return isFirstNameValid
        case 1: return isLastNameValid
        default: return isEmailValid
        }
    }

    var body: some View {
        ZStack {
            Color.llGreen.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                TabView(selection: $currentPage) {
                    page(title: "What's your first name?",
                         placeholder: "First Name",
                         text: $firstName,
                         keyboard: .default,
                         contentType: .givenName)
                        .tag(0)

                    page(title: "What's your last name?",
                         placeholder: "Last Name",
                         text: $lastName,
                         keyboard: .default,
                         contentType: .familyName)
                        .tag(1)

                    page(title: "What's your email address?",
                         placeholder: "Email Address",
                         text: $email,
                         keyboard: .emailAddress,
                         contentType: .emailAddress,
                         errorMessage: (!email.isEmpty && !isEmailValid) ? "Please enter a valid email address." : nil)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                // Block swiping forward when the current page isn't valid.
                .onChange(of: currentPage) { newValue in
                    if newValue > 0 && !isFirstNameValid { currentPage = 0 }
                    else if newValue > 1 && !isLastNameValid { currentPage = 1 }
                }

                actionButton
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
            }
        }
    }

    // MARK: - Subviews
    private var header: some View {
        VStack(spacing: 4) {
            Text("Little Lemon")
                .font(.system(size: 36, weight: .bold, design: .serif))
                .foregroundColor(.llYellow)
            Text("Let's get to know you")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }

    private func page(title: String,
                      placeholder: String,
                      text: Binding<String>,
                      keyboard: UIKeyboardType,
                      contentType: UITextContentType,
                      errorMessage: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 26, weight: .semibold, design: .serif))
                .foregroundColor(.white)

            TextField(placeholder, text: text)
                .keyboardType(keyboard)
                .textContentType(contentType)
                .autocapitalization(keyboard == .emailAddress ? .none : .words)
                .disableAutocorrection(true)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .foregroundColor(.black)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.llYellow)
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }

    private var actionButton: some View {
        Button(action: handleAction) {
            Text(currentPage == 2 ? "Finish" : "Next")
                .font(.headline)
                .foregroundColor(.llGreen)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isCurrentPageValid ? Color.llYellow : Color.gray.opacity(0.5))
                .cornerRadius(10)
        }
        .disabled(!isCurrentPageValid)
    }

    // MARK: - Actions
    private func handleAction() {
        if currentPage < 2 {
            withAnimation {
                currentPage += 1
            }
        } else if isFirstNameValid && isLastNameValid && isEmailValid {
            firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
            email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            isLoggedIn = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}