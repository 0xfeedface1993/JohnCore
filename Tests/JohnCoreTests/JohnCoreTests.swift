import XCTest
@testable import JohnCore

final class JohnCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JohnCore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
    /// 验证邮箱方法测试
    func testEmail() {
        let goodEmail = ["318715498@qq.com", "开心2019@hotmail.com"]
        let badEmails = ["happp@", "@qq.com", "12332423", "背景"]
        for i in goodEmail {
            XCTAssert(i.isEmailAddress(), "正确邮箱验证失败：\(i)")
        }
        for i in badEmails {
            XCTAssert(!i.isEmailAddress(), "非法邮箱验证失败：\(i)")
        }
    }
}
