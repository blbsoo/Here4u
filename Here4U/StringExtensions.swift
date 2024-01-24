import Foundation

extension String {
    // Validation for email
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    // Validation for password length
    func isValidPassword() -> Bool {
        return self.count >= 8
    }

    // Check if passwords match
    func passwordsMatch(_ confirmPassword: String) -> Bool {
        return self == confirmPassword
    }
}
