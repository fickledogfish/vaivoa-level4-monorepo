import Foundation
import UIKit

extension UITableViewCell {
    var textLabel: String? {
        get {
            (contentConfiguration as? UIListContentConfiguration)?.text
        }

        set {
            var content = contentConfigurationOrDefault()
            content.text = newValue

            contentConfiguration = content
        }
    }

    var detailTextLabel: String? {
        get {
            (contentConfiguration as? UIListContentConfiguration)?.secondaryText
        }

        set {
            var content = contentConfigurationOrDefault()
            content.secondaryText = newValue

            contentConfiguration = content
        }
    }

    func contentConfigurationOrDefault() -> UIListContentConfiguration {
        contentConfiguration as? UIListContentConfiguration ?? defaultContentConfiguration()
    }
}
