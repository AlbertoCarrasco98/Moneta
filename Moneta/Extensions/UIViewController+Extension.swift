import UIKit

extension UIViewController {

    func showToast(withMessage message: String,
                   duration: TimeInterval = 2.0,
                   color: UIColor.ToastColor,
                   position: Toast.ToastPosition) {

        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)

        toastLabel.textColor = .white
        toastLabel.backgroundColor = color.defaultColor

        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let maxSizeTitle = CGSize(width: view.bounds.size.width - 40, height: view.bounds.size.height)
        var expectedSizeTitle = toastLabel.sizeThatFits(maxSizeTitle)
        expectedSizeTitle.width += 20
        expectedSizeTitle.height += 20
        toastLabel.frame = CGRect(x: view.frame.size.width/2 - expectedSizeTitle.width/2,
                                  y: position.defaultHeight - expectedSizeTitle.height / 2,
                                  width: expectedSizeTitle.width,
                                  height: expectedSizeTitle.height)
        view.addSubview(toastLabel)
        toastLabel.alpha = 0.0

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: duration,
                           options: .curveEaseOut,
                           animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
}

