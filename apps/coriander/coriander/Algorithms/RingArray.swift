//
//  RingArray.swift
//  coriander
//
//  Created by Tomas Korcak on 17.05.2021.
//

public struct RingArray<T> {
    private var _array: [T] = []
    private var _maxCount: Int
    private var _offset: Int = 0
    
    // -----
    // MARK: Constructor
    // -----
    
    public init(maxCount: Int) {
        _maxCount = maxCount
    }
    
    // -----
    // MARK: Getters / Setters
    // -----
    
    public var capacity: Int {
        _array.capacity
    }
    
    public var count: Int {
        _array.count
    }
    
    public var internalArray: [T] {
        _array
    }
    
    public var maxCount: Int {
        self._maxCount
    }
    
    // -----
    // MARK: Operators
    // -----
    
    subscript(index:Int) -> T {
        get {
            return _array[index % count]
        }
    }
    
    // -----
    // MARK: Methods
    // -----
    
    public mutating func append(_ value: T) {
        if (count < maxCount) {
            _array.append(value)
        } else {
            _array[_offset] = value
        }
        
        _offset = (_offset + 1) % maxCount
    }
}

extension RingArray: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        if count < 1 {
            return AnyIterator {
                nil
            }
        }
        
        var counter = 0
        
        return AnyIterator {
            guard counter < self.count  else {
                return nil
            }
            
            let value: T = self[self._offset + counter]
            
            defer {
                counter += 1
            }
            
            return value
        }
    }
}
