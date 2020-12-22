

import UIKit

extension UIViewController
{
    static func instantiate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    func setBackButton(title: String, color: UIColor = .label) {
        let backBarButtonItem = UIBarButtonItem(
            title: title,
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        backBarButtonItem.tintColor = .label
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
