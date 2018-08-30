import XCTest
import FBSnapshotTestCase
@testable import Folio_UI_Collection

class SubmissionStatusButtonTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
    }

    func testSubmissionStatusButton() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 90))
        container.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        let submissionStatusButton = SubmissionStatusButton(type: .custom)
        submissionStatusButton.setTitle("お客様情報の入力", for: .normal)
        container.addSubview(submissionStatusButton)

        submissionStatusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submissionStatusButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            submissionStatusButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            submissionStatusButton.widthAnchor.constraint(equalToConstant: 260),
            submissionStatusButton.heightAnchor.constraint(equalToConstant: 50)])
        submissionStatusButton.frame = CGRect(x: 0, y: 0, width: 260, height: 50)

        submissionStatusButton.submissionStatus = .notStarted
        XCTAssertEqual(submissionStatusButton.isEnabled, true)
        FBSnapshotVerifyView(container, identifier: "NotStarted")

        submissionStatusButton.submissionStatus = .inProgress
        XCTAssertEqual(submissionStatusButton.isEnabled, true)
        FBSnapshotVerifyView(container, identifier: "InProgress")

        submissionStatusButton.submissionStatus = .completed
        XCTAssertEqual(submissionStatusButton.isEnabled, false)
        FBSnapshotVerifyView(container, identifier: "Completed")

        submissionStatusButton.submissionStatus = .rejected
        XCTAssertEqual(submissionStatusButton.isEnabled, true)
        FBSnapshotVerifyView(container, identifier: "Rejected")
    }
}
