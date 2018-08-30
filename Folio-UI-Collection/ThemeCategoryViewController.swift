import UIKit

private let pageCount = 3

class ThemeCategoryViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet private var containerScrollView: UIScrollView!
    @IBOutlet private var imageScrollView: UIScrollView!
    @IBOutlet private var themeScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let pageWidth = imageScrollView.bounds.width
        if contentOffset.x >= 0 && contentOffset.x <= pageWidth * CGFloat(pageCount - 1) {
            imageScrollView.contentOffset.x = contentOffset.x
        }
        let scrollFactor = themeScrollView.bounds.width / pageWidth
        themeScrollView.contentOffset.x = contentOffset.x * scrollFactor
    }
}

class ScrollView: UIScrollView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        next?.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        next?.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        next?.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        next?.touchesCancelled(touches, with: event)
    }
}
