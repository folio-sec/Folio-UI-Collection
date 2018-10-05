import UIKit

@IBDesignable
class PrimaryButton: ContainedButton {
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
    }

    private func commonInit() {
        containerColor = UIColor(red: 242/255, green: 97/255, blue: 97/255, alpha: 1)
        highlightedContainerColor = containerColor.withAlphaComponent(0.9)
        selectedContainerColor = containerColor
        disabledContainerColor = UIColor(red: 218/255, green: 219/255, blue: 227/255, alpha: 1)
        cornerRadius = 4
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        setBackgroundImage(containerColor.image(), for: .normal)
        setBackgroundImage(highlightedContainerColor.image(), for: .highlighted)
        setBackgroundImage(selectedContainerColor.image(), for: .selected)
        setBackgroundImage(disabledContainerColor.image(), for: .disabled)
    }
}
