//
//  PKCanvasView+.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/18/22.
//

import PencilKit

extension PKCanvasView {
    var memento: DrawingMemento {
        let drawing = drawing
        return PKCanvasViewMemento(pkDrawing: drawing)
    }

    func restore(with memento: DrawingMemento) {
        guard let pkCanvasViewMemento = memento as? PKCanvasViewMemento else { return }

        drawing = pkCanvasViewMemento.pkDrawing
    }

    struct PKCanvasViewMemento: DrawingMemento {
        let pkDrawing: PKDrawing
        let date = Date()
    }
}

