//
//  Coordinatable.swift
//  UICommon
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation

public protocol Coordinatable: class {
    associatedtype InputType
    associatedtype OutputType

    func start(with option: InputType, animated: Bool)
    var output: ((OutputType) -> Void)? {get set}
}

public typealias CoordinatableFactoryResult<Input, Output> = (coordinator: AnyCoordinatable<Input, Output>, presentable: Presentable)

public final class AnyCoordinatable<InputType, OutputType>: Coordinatable {
    private let setOutputClosure: (((OutputType) -> Void)?) -> Void
    private let getOutputClosure: () -> ((OutputType) -> Void)?
    private let startClosure: (InputType, Bool) -> Void

    public init<T: Coordinatable>(_ coordionator: T) where T.InputType == InputType, T.OutputType == OutputType {
        startClosure = { (option, animated) in
            coordionator.start(with: option, animated: animated)
        }

        getOutputClosure = { () -> ((OutputType) -> Void)? in
            return coordionator.output
        }

        setOutputClosure = { output in
            coordionator.output = output
        }
    }

    public func start(with option: InputType, animated: Bool) {
        startClosure(option, animated)
    }

    public var output: ((OutputType) -> Void)? {
        get {
            return getOutputClosure()
        }

        set {
            setOutputClosure(newValue)
        }
    }
}
