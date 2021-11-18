import Foundation

extension String {
    func contains(any substrings: [SubSequence], ignoreCase: Bool = true) -> Bool {
        let this = ignoreCase ? self.lowercased() : self

        for substring in substrings {
            if this.contains(ignoreCase ? substring.lowercased() : String(substring)) {
                return true
            }
        }

        return false
    }
}
