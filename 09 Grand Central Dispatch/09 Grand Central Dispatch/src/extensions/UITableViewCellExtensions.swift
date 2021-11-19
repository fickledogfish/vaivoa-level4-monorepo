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

    fileprivate func contentConfigurationOrDefault() -> UIListContentConfiguration {
        var contentConfig = contentConfiguration as? UIListContentConfiguration

        if contentConfig == nil {
            contentConfig = defaultContentConfiguration()

            contentConfig!.textProperties.numberOfLines = 1
            contentConfig!.secondaryTextProperties.numberOfLines = 3
        }

        return contentConfig!
    }
}
