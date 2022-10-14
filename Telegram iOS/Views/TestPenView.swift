//
//  TestPenView.swift
//  Telegram iOS
//
//  Created by eldorbek nusratov on 10/14/22.
//

import SwiftUI

struct TestPenView: View {
    var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                Image(Images.toolBasePen.rawValue).tint(.cyan)
            } else {
                // Fallback on earlier versions
            }
            Image(Images.toolTipPen.rawValue)
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 6.0, style: .continuous)
                    .fill(.cyan)
                    .frame(width: 102.0, height: 82.0)
                    .offset(x: 0.0, y: -24.0)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct TestPenView_Previews: PreviewProvider {
    static var previews: some View {
        TestPenView()
    }
}
