import UIKit

class InsetTextField: UITextField {

    var spacing: UIEdgeInsets

    init(spacing: UIEdgeInsets) {
        self.spacing = spacing
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // rectángulo donde aparece el texto/placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: spacing)
    }

    // rectángulo cuando se está editando el texto
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: spacing)
    }

    // rectángulo donde aparece el placeholder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: spacing)
    }
}
