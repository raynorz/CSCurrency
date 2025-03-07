//
//  CurrencyServiceTests.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import XCTest

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
            XCTAssertEqual(response.count, 20)
            
            let currency = response.first
            XCTAssertNotNil(currency)
            
            XCTAssertEqual(currency!.shortName, "AUD")
            XCTAssertEqual(currency!.validFrom, "2022-04-26T00:00:00")
            XCTAssertEqual(currency!.name, "Dollar")
            XCTAssertEqual(currency!.country, "Australia")
            XCTAssertEqual(currency!.move, -0.5)
            XCTAssertEqual(currency!.amount, 1)
            XCTAssertEqual(currency!.valBuy, 15.74)
            XCTAssertEqual(currency!.valSell, 16.88)
            XCTAssertEqual(currency!.valMid, 16.306)
            XCTAssertEqual(currency!.currBuy, 15.898)
            XCTAssertEqual(currency!.currSell, 16.714)
            XCTAssertEqual(currency!.currMid, 16.306)
            XCTAssertEqual(currency!.version, 1)
            XCTAssertEqual(currency!.cnbMid, 16.31)
            XCTAssertEqual(currency!.ecbMid, 1.497)
        } catch {
            XCTFail("Failed with error: \(error)")
        }
    }
}
