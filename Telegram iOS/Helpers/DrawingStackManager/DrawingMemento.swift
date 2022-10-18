//
//  File.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/18/22.
//

import PencilKit

protocol DrawingMemento {
    var pkDrawing: PKDrawing { get }
    var date: Date { get }
}
