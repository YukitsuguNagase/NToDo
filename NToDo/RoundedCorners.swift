//
//  RoundedCorners.swift
//  NToDo
//
//  Created by YukitsuguNagase on 2021/04/25.
//

import SwiftUI

struct RoundedCorners: Shape {
    var topleft: CGFloat = 0.0
    var topright: CGFloat = 0.0
    var bottomleft: CGFloat = 0.0
    var bottomright: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        let topleft = min(min(self.topleft, height/2), width/2)
        let topright = min(min(self.topright, height/2), width/2)
        let bottomleft = min(min(self.bottomleft, height/2), width/2)
        let bottomright = min(min(self.bottomright, height/2), width/2)
        
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topleft, y:0))
        path.addArc(center: CGPoint(x: width - topright,y:topright), radius: topright,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: width, y: height - bottomright))
        path.addArc(center: CGPoint(x: width - bottomright,y:height - bottomright), radius: bottomright,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bottomleft, y:height))
        path.addArc(center: CGPoint(x: bottomleft,y: height - bottomleft), radius: bottomleft,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y:topleft))
        path.addArc(center: CGPoint(x: topleft,y: topleft), radius: topleft,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        path.closeSubpath()
        
        
        
        return path
        
    }
    
}

struct RoundedCorners_Previews: PreviewProvider {
    static var previews: some View {
        RoundedCorners(topleft: 30, topright: 30, bottomleft: 30, bottomright: 30).stroke().padding()
    }
}
