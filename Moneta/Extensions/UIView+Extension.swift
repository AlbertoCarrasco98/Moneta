import UIKit

class SpacerView: UIView {

    enum Axis {
        case horizontal
        case vertical
    }

    init(axis: Axis, space: CGFloat) {
        super.init(frame: .zero)
        switch axis {
            case .horizontal:
                self.widthAnchor.constraint(equalToConstant: space).isActive = true
            case .vertical:
                self.heightAnchor.constraint(equalToConstant: space).isActive = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
