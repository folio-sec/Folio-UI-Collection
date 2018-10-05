import UIKit
import RxSwift
import RxCocoa

class WalkthroughViewController: UIViewController {
    @IBOutlet weak var outerScrollView: UIScrollView!
    @IBOutlet weak var innerScrollView: UIScrollView!
    @IBOutlet weak var bezelScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outerScrollView.contentInsetAdjustmentBehavior = .never

        outerScrollView.rx.contentOffset
            .subscribe(onNext: { [weak self] in
                guard let innerScrollView = self?.innerScrollView, let bezelScrollView = self?.bezelScrollView else {
                    return
                }
                
                innerScrollView.contentOffset.x = min($0.x, innerScrollView.bounds.width)

                let factor = bezelScrollView.bounds.width / innerScrollView.bounds.width
                let offsetX = max(0, min(($0.x - innerScrollView.bounds.width) * factor,
                                         bezelScrollView.contentSize.width - bezelScrollView.bounds.width))
                bezelScrollView.contentOffset.x = offsetX
            })
            .disposed(by: disposeBag)

        outerScrollView.rx.currentPage
            .subscribe(onNext: { [weak self] in
                self?.pageControl.currentPage = $0
            })
            .disposed(by: disposeBag)
        pageControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let currentPage = self?.pageControl.currentPage else { return }
                self?.outerScrollView.setCurrentPage(currentPage, animated: true)
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func done(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

private extension Reactive where Base: UIScrollView {
    var currentPage: Observable<Int> {
        return didEndDecelerating.map({
            let pageWidth = self.base.frame.width
            let page = floor((self.base.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            return Int(page)
        })
    }
}

private extension UIScrollView {
    func setCurrentPage(_ page: Int, animated: Bool) {
        var rect = bounds
        rect.origin.x = rect.width * CGFloat(page)
        rect.origin.y = 0
        scrollRectToVisible(rect, animated: animated)
    }
}
