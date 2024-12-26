import UIKit

class Toast {
    enum ToastPosition {
        case top
        case center
        case bottom
        
        var defaultHeight: CGFloat {
            switch self {
                case .top:
                    return 100
                case .center:
                    return UIScreen.main.bounds.height / 2
                case .bottom:
                    return UIScreen.main.bounds.height - 180
            }
        }
    }
}
