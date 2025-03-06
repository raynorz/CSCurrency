//
//  CurrencyServiceTests.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import XCTest

final class MockAPIManager: APIManager {
    func request<T>(endpoint: any APIRequestConvertible) async throws -> T where T : Decodable {
        throw NetworkingError.notFound
    }
}

final class CurrencyServiceTests: XCTestCase {
    var currencyService: CurrencyServiceProtocol!
    
    override func setUp() {
        super.setUp()
        
        currencyService = CurrencyService(apiManager: MockAPIManager())
    }
    
    override func tearDown() {
        super.tearDown()
        
        currencyService = nil
    }
    
    func testGetExchangeList() async {
        do {
            let response = try await currencyService.getCurrenciesExchange()
            
            XCTAssertNotNil(response)
        } catch {
            XCTFail("Failed with error: \(error)")
        }
    }
}
