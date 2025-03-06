struct CurrencyResponse: Codable {
    let shortName: String
    let validFrom: String
    let name, country: String
    let move: Double
    let amount: Int
    let valBuy, valSell, valMid, currBuy: Double
    let currSell, currMid: Double
    let version: Int
    let cnbMid, ecbMid: Double
}
