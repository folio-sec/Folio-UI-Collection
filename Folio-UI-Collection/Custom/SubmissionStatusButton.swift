import UIKit

@IBDesignable
final class SubmissionStatusButton: TextButton {
    enum SubmissionStatus {
        case notStarted
        case inProgress
        case completed
        case rejected
    }

    var submissionStatus: SubmissionStatus = .notStarted {
        didSet {
            setImage(statusIcon, for: .normal)
            tintColor = statusIconColor
            isEnabled = submissionStatus != .completed
            inProgressMark.isHidden = submissionStatus != .inProgress
        }
    }
    var inProgressMark = ContainedButton()

    override var isEnabled: Bool {
        didSet {
            setShadowVisible(isEnabled)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            setShadowVisible(!isHighlighted)
        }
    }

    private var statusIcon: UIImage {
        let bundle = Bundle(for: type(of: self))
        switch submissionStatus {
        case .notStarted, .inProgress, .completed:
            return UIImage(named: "checkmark", in: bundle, compatibleWith: nil)!
        case .rejected:
            return UIImage(named: "warning", in: bundle, compatibleWith: nil)!
        }
    }

    private var statusIconColor: UIColor {
        switch submissionStatus {
        case .notStarted, .inProgress:
            return Color.Palette.lightGray
        case .completed:
            return Color.Palette.green
        case .rejected:
            return Color.Palette.yellow
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        inProgressMark.prepareForInterfaceBuilder()
    }

    private func commonInit() {
        submissionStatus = .notStarted

        adjustsImageWhenHighlighted = false
        backgroundColor = .white
        setBackgroundImage(Color.Palette.snowWhite.image(), for: .highlighted)
        setBackgroundImage(Color.Palette.snowWhite.image(), for: .disabled)

        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitleColor(Color.Palette.black, for: .normal)
        if #available(iOS 11.0, *) {
            contentHorizontalAlignment = .leading
        } else {
            contentHorizontalAlignment = .left
        }

        layer.cornerRadius = 8
        setShadowVisible(isEnabled)

        inProgressMark.isUserInteractionEnabled = false
        inProgressMark.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        inProgressMark.setTitle("入力中", for: .normal)
        inProgressMark.containerColor = Color.Palette.yellow
        inProgressMark.cornerRadius = 10
        addSubview(inProgressMark)

        inProgressMark.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inProgressMark.widthAnchor.constraint(equalToConstant: 48),
            inProgressMark.heightAnchor.constraint(equalToConstant: 20),
            inProgressMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            inProgressMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
    }

    func setShadowVisible(_ isVisible: Bool) {
        if isVisible {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.12
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 6
            layer.masksToBounds = false
        } else {
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOpacity = 0
            layer.shadowOffset = .zero
            layer.shadowRadius = 0
            layer.masksToBounds = true
        }
    }
}
