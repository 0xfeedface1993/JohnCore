//
//  File.swift
//  
//
//  Created by JohnConner on 2020/3/20.
//

import Foundation

extension Data {
    /// JSON数据解析，将二进制数据转成JSON对象
    public func json<T: Codable>() -> T? {
        do {
            let json = try JSONDecoder().decode(T.self, from: self)
            return json
        } catch {
            print(">>> \(error.localizedDescription)")
            let str = String(data: self, encoding: .utf8)
            print(">>> \(str ?? "Non-String Data!")")
            return nil
        }
    }
}
