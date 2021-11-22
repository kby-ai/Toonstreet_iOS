//
//  TSItem.swift
//  Toonstreet
//
//  Created by Kavin Soni on 21/11/21.
//

import UIKit
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
struct TSItem<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
extension Container where Item == Int {
    
    func getValue(index:Int) -> Int {
        return self[index]
    }
}
extension Container where Item == String {
    
    func getValue(index:Int) -> String {
        return self[index]
    }
}
