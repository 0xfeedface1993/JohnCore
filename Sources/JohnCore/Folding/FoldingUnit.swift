//
//  FoldingUnit.swift
//  AiErXin
//
//  Created by JohnConner on 2020/11/19.
//  Copyright © 2020 tenpoint. All rights reserved.
//

import Foundation

public protocol PeriodElement: Equatable {
    var childrens: [Self] { get }
}

open class FoldingPeriod<T: PeriodElement>: Equatable {
    public static func == (lhs: FoldingPeriod<T>, rhs: FoldingPeriod<T>) -> Bool {
        let lp: FoldingPeriod<T>? = lhs.parent
        let rp: FoldingPeriod<T>? = rhs.parent
        return lhs.data == rhs.data && lhs.children == rhs.children && lhs.isCollapse == rhs.isCollapse && lp == rp
    }
    
    public typealias Value = FoldingPeriod<T>
    
    /// 章节/课节标题
    public var data: T
    /// 子级, 供外部进行当前显示行数的计算之类的
    public var children: [Value]
    /// 是否收缩子集
    public var isCollapse: Bool = false
    /// 父级
    public weak var parent: Value?
    
    /// 当前级数
    public var level: Int { parent == nil ? 0:(1 + parent!.level) }
    
    public init(data: T) {
        self.data = data
        self.children = data.childrens.map({ Value(data: $0) })
        self.children.forEach({ $0.parent = self })
    }
    
    /// 将链表转换成一维列表
    public var flatRows: [Value] { [self] + (isCollapse ? []:children.flatMap({ $0.flatRows })) }
    /// 将链表转换成一维列表(不包含本级)
    public var subsRows: [Value] { isCollapse ? []:children.flatMap({ $0.flatRows }) }
    
    /// 一维列表中指定位置的数据，若此位置不在列表中则返回nil
    /// - Parameter index:  一维列表中的位置
    /// - Returns: 指定位置相关数据
    static private func value(in items: [Value], index: Int) -> (state: Bool, lastIndex: Int, value: Value?)? {
        guard index >= 0 else {
            print(">>> 所指定的index不合法：\(index)")
            return nil
        }
        
        var currentIndex = 0
        for i in items {
            let next: (Bool, Int, Value?) = i.value(for: currentIndex, targetIndex: index)
            if next.0 {
                return (next.0, lastIndex: next.1, value: next.2)
            }
            currentIndex = next.1
        }
        
        print(">>> 所指定的index不合法：\(index), 当前最大index为 \(currentIndex)")
        return nil
    }
    
    /// 一维列表中指定位置的数据，若此位置不在列表中则返回nil
    /// - Parameter index: 一维列表中的位置
    /// - Returns: 指定位置数据
    public static func search(in items: [Value], index: Int) -> Value? { value(in: items, index: index)?.value }
    
    /// 更新一维列表指定位置中数据
    /// - Parameters:
    ///   - items: 链表
    ///   - index: 一维列表中的位置
    ///   - completion: 找到后会调用此闭包更新
    public static func update(items: [Value], index: Int, completion: (Value) -> Void) {
        guard let item = search(in: items, index: index) else { return }
        completion(item)
    }
    
    /// 当前项和其展开子项显示数量
    public var visibleRowsCount: Int {
        guard let _ = parent else {
            return isCollapse ? 1:(children.map({ $0.visibleRowsCount }).reduce(0, { $0 + $1 }) + 1)
        }
        return isCollapse ? 1:(children.map({ $0.visibleRowsCount }).reduce(0, { $0 + $1 }) + 1)
    }
    
    /// 搜索当前项及指定index目标, 若不存在则返回state为false
    /// - Parameters:
    ///   - lastIndex: 起始位置，也就是队列中上一个元素的最大index
    ///   - targetIndex: 需要查找的一维列表位置
    /// - Returns: state：是否包含对应的index项，lastIndex为累计的最大index，value为搜索结果（未找到则是nil）
    public func value(for lastIndex: Int, targetIndex: Int) -> (state: Bool, lastIndex: Int, value: Value?) {
        // 当前项即为目标项
        if lastIndex == targetIndex {
            print(">>> bingo tar: \(targetIndex), last: \(lastIndex)")
            return (true, lastIndex, self)
        }
        
        // 若当前项收缩, 位置下移一位，则返回
        if self.isCollapse {
            return (false, lastIndex + 1, nil)
        }
        
        // 开始处理子项
        var currentIndex = lastIndex + 1
        for i in children {
            // 获取子项搜索结果, 一旦满足targetIndex条件则返回state=true
            let next: (state: Bool, lastIndex: Int, value: Value?) = i.value(for: currentIndex, targetIndex: targetIndex)
            if next.state {
                print(">>> found: \(currentIndex), tar: \(targetIndex), last: \(next.lastIndex)")
                return next
            }
            print(">>> search: \(currentIndex), tar: \(targetIndex)")
            // 不满足则累加子项的展开级数
            currentIndex = next.lastIndex
        }
        
        // 这个情况说明targetIndex超出了当前项及子项的最大级数
        return (false, currentIndex, nil)
    }
}

public protocol JolinList: class {
    associatedtype T : PeriodElement
    var jolins: [FoldingPeriod<T>] { get set }
}

extension JolinList {
    /// 更新一维列表，收缩或展开指定位置的可展示子集
    /// - Parameters:
    ///   - parentIndex: 指定位置
    ///   - state: 收缩或展开
    public func update(parentIndex: Int, state: Bool) -> Range<Int>? {
        guard parentIndex >= 0, parentIndex < jolins.count else {
            print(">>> invalid index \(parentIndex)")
            return nil
        }
        return update(parentValue: jolins[parentIndex], index: parentIndex, state: state)
    }
    
    /// 更新一维列表，收缩或展开指定元素的可展示子集
    /// - Parameters:
    ///   - parentValue: 指定元素
    ///   - index: 指定位置
    ///   - state: 收缩或展开
    private func update(parentValue: FoldingPeriod<T>, index: Int?, state: Bool) -> Range<Int>? {
        guard let parentIndex = index ?? jolins.firstIndex(where: { $0 == parentValue }) else {
            print(">>> invalid parent value: \(parentValue)")
            return nil
        }
        parentValue.isCollapse = state
        let startIndex = parentIndex + 1
        if !state {
            let rows = parentValue.subsRows
            if jolins.count > startIndex {
                jolins.insert(contentsOf: rows, at: startIndex)
            }   else    {
                jolins.append(contentsOf: rows)
            }
            return startIndex..<(startIndex + rows.count)
        }   else    {
            let endIndex = jolins.count - 1
            guard startIndex < endIndex else {
                // 当只有一个元素的时候，要特殊处理
                // 只需要返回一个元素的区间
                if startIndex == endIndex {
                    jolins.remove(at: startIndex)
                    return startIndex..<(startIndex + 1)
                }
                print(">>> invalid range \(startIndex)...\(endIndex)")
                return nil
            }
            
            if let lastIndex = jolins[startIndex...endIndex].firstIndex(where: { $0.level <= parentValue.level }) {
                jolins.removeSubrange(startIndex..<lastIndex)
                return startIndex..<lastIndex
            }   else    {
                let boundsIndex = endIndex
                jolins.removeSubrange(startIndex...boundsIndex)
                return startIndex..<(boundsIndex + 1)
            }
        }
    }
}
