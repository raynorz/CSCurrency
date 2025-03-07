//
//  CurrenciesListViewModelTests.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 07.03.2025.
//

import XCTest

@MainActor
final class CurrenciesListViewModelTests: XCTestCase {
    var mockApiManager: MockAPIManager!
    var viewModel: CurrenciesListViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockApiManager = MockAPIManager()
        let service = CurrencyService(apiManager: mockApiManager)
        let useCase = GetCurrenciesUseCase(service: service)
        viewModel = CurrenciesListViewModel(getCurrenciesUseCase: useCase)
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockApiManager = nil
        viewModel = nil
    }
    
    func testGetCurrencies_Success() async {
        // given
        mockApiManager.resultType = .success
        
        // when
        await viewModel.getCurrencies()
        
        // then
        XCTAssertNil(viewModel.alertType)
        XCTAssertFalse(viewModel.currencies.isEmpty)
    }
    
    func testGetCurrencies_Fail() async {
        // given
        mockApiManager.resultType = .error
        
        // when
        await viewModel.getCurrencies()
        
        // then
        XCTAssertNotNil(viewModel.alertType)
        XCTAssertTrue(viewModel.currencies.isEmpty)
    }
}
