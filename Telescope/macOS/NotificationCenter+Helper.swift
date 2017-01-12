//
//  NotificationCenter+Helper.swift
//  Telescope
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation

public struct NotificationDescriptor<A> {
    public let name: Notification.Name
    public let convert: (Notification) -> A
}

public struct CustomNotificationDescriptor<A> {
    public let name: Notification.Name
}

public class Token {
    private let token: NSObjectProtocol
    private let center: NotificationCenter
    public init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }

    deinit {
        center.removeObserver(token)
    }
}

extension NotificationCenter {
    public func addObserver<A>(descriptor: NotificationDescriptor<A>, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil, using: { note in
            block(descriptor.convert(note))
        })
        return Token(token: token, center: self)
    }

    public func addObserver<A>(descriptor: CustomNotificationDescriptor<A>, queue: OperationQueue? = nil, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: queue, using: { note in
            block(note.object as! A)
        })
        return Token(token: token, center: self)
    }

    public func post<A>(descriptor: CustomNotificationDescriptor<A>, value: A) {
        post(name: descriptor.name, object: value)
    }
}
