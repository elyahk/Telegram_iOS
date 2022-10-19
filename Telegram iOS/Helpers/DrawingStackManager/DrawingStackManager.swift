//
//  DrawingStackManager.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/18/22.
//

import PencilKit

class DrawingStackManager {
    private(set) var mementos = [DrawingMemento]()
    private let pkCanvasView: PKCanvasView

    init(_ pkCanvasView: PKCanvasView) {
        self.pkCanvasView = pkCanvasView
    }

    func save() {
        mementos.append(pkCanvasView.memento)
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        pkCanvasView.restore(with: mementos.removeLast())
    }

    func clear() {
        pkCanvasView.drawing = PKDrawing()
        mementos = []
    }
}
