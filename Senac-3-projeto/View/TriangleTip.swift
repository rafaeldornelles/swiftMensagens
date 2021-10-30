//
//  TriangleTip.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct TriangleTip: Shape {
    func path(in rect: CGRect)-> Path{
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY-10))
        path.addLine(to: CGPoint(x: rect.maxX+15, y: rect.maxY-10))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 25))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-10))
        
        return path
    }
}

struct TriangleTip_Previews: PreviewProvider {
    static var previews: some View {
        TriangleTip()
    }
}
