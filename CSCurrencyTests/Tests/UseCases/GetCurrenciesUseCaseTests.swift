//
//  GetCurrenciesUseCaseTests.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

import XCTest

final class GetCurrenciesUseCaseTests: XCTestCase {
    var useCase: GetCurrenciesUseCaseProtocol!
    
    override func setUp() {
        super.setUp()
        
        useCase = GetCurrenciesUseCase(service: CurrencyService(apiManager: MockAPIManager()))
    }
    
    override func tearDown() {
        super.tearDown()
        
        useCase = nil
    }
    
    func testGetCurrencies() async {
        do {
            let result = try await useCase.getCurrencies()
            
            XCTAssertNotNil(result)
            XCTAssertEqual(result.count, 13)
            
            let currencyData = result.first
            XCTAssertNotNil(currencyData)
            
            XCTAssertEqual(currencyData!.name, "Dollar")
            XCTAssertEqual(currencyData!.amount, 1)
            XCTAssertEqual(currencyData!.country, "Australia")
            
        } catch {
            XCTFail("Failed with error: \(error)")
        }
    }
}
