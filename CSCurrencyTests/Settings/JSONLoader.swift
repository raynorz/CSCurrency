//
//  JSONLoader.swift
//  CSCurrency
//
//  Created by Daniel Brezina on 06.03.2025.
//

import Foundation

final class JSONLoader {
    enum TestError: Error {
        case fileNotFound
        case fileNotDecoded
    }

    func getData(fromJSON fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw TestError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw TestError.fileNotDecoded
        }
    }

    func loadJSON<T: Decodable>(fileName: String) throws -> T {
        do {
            let data = try getData(fromJSON: fileName)
            let decodedObject = try CustomJSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw error
        }
    }
    
    func getExample<T: Decodable>(request: APIRequestConvertible) -> T? {
        do {
            let data: T = try loadJSON(fileName: request.fileName)
            return data
        } catch {
            print("❌ Can't get the file \(request.fileName) \(error)")
            return nil
        }
    }
}
