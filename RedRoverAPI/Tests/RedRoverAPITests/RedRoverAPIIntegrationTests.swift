import XCTest
@testable import RedRoverAPI


@available(iOS 15.0.0, *)
final class RedRoverAPIIntegrationTests: XCTestCase {
    
    private var apiClient: RedRoverAPIClient?
    
    override func setUp() {
        self.apiClient = RedRoverAPIClient()
    }
    
    func testPhotoManifestAPICallSuccess() async {
        // GIVEN: an API client
        // WHEN: we ask for the manifests
        guard let manifestResult = await apiClient?
                .photoManifest(forRover: .curiosity) else {
                    XCTAssert(false, "Did not receive manifest")
                    return
                }
        
        // THEN: they are retrieved correctly
        switch manifestResult {
        case .success(let photoManifest):
            XCTAssertNotNil(photoManifest)
        case .failure(let error):
            XCTAssert(false, error.localizedDescription)
        }
    }
}
