# HttpClient Demo
Http library demo for https://httpbin.org

## Usage
Get an Json Object from HttpBin server.

```swift
HttpBinManager.shared.getJsonObjectFromHttpBin(onSuccess: { (result) in
    if let json = result {
        print("[ViewController] Json: \(json.description)")
    }
}, onError: { (error) in
    print(error.localizedDescription)
})
```

Get an swift object from HttpBin server.
```swift
HttpBinManager.shared.getHttpBinResponse(onSuccess: { (result) in
        print("[ViewController] object: \(result?.url ?? "nil")")
}, onError: { (error) in
    print(error.localizedDescription)
})
```

## Test
Test that the result is as expected.

```swift
func testGetJsonObjectFromHttpBin_useFakeResponse_returnJson() {
    // 1. Arrange
    let promise = expectation(description: "Get response success.")
    var jsonObject: JsonObject? = nil

    // 2. Act
    self.httpClient?.response = self.mockResponse
    self.manager?.setHttpClient(self.httpClient)
    self.manager?.getJsonObjectFromHttpBin(onSuccess: { (result) in
        jsonObject = result
        promise.fulfill()
    }, onError: { (error) in
        XCTFail(error.localizedDescription)
    })
    waitForExpectations(timeout: 2, handler: nil)

    // 3. Assert
    XCTAssertNotNil(jsonObject, "The jsonObject shouldn't be nil.")
    XCTAssertEqual(jsonObject?.count, 3, "The count should be 3.")
    XCTAssertNotNil(jsonObject?["username"], "The jsonObject doesn't contain username key.")
    XCTAssertEqual(jsonObject?["username"] as? String, "Rodrigo", "The username shoudl be Rodrigo.")
    XCTAssertNotNil(jsonObject?["email"], "The jsonObject doesn't contain email key.")
    XCTAssertEqual(jsonObject?["email"] as? String, "em@il.com", "The email shoudl be em@il.com.")
    XCTAssertNotNil(jsonObject?["age"], "The jsonObject doesn't contain age key.")
    XCTAssertEqual(jsonObject?["age"] as? Int, 29, "The age shoudl be 29.")
}
```
