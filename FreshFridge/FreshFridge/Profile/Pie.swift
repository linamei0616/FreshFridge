//
//  Pie.swift
//  PieChart
//
//  Created by Salvador Garcia on 1/19/23.
//

import SwiftUI

//struct Pie: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct Pie: View {

    
    
    var slices: [(Double, Color)]
//    @AppStorage("wasted") var wastedItems : Int = 0
//    @AppStorage("saved") var savedItems : Int = 0
    
    var body: some View {
        VStack() {
            Canvas { context, size in
//                slices = [(Double(wastedItems), .red), (Double(savedItems), .blue)]
                let total = slices.reduce(0) { $0 + $1.0 }
                context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                var pieContext = context
                pieContext.rotate(by: .degrees(-90))
                let radius = min(size.width, size.height) * 0.48
                var startAngle = Angle.zero
                for (value, color) in slices {
                    let angle = Angle(degrees: 360 * (value / total))
                    let endAngle = startAngle + angle
                    let path = Path { p in
                        p.move(to: .zero)
                        p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        p.closeSubpath()
                    }
                    pieContext.fill(path, with: .color(color))

                    startAngle = endAngle
                        
                }
//                    .aspectRatio(1, contentMode: .fit)
            }
            .frame(width: 250, height: 250)
            
//            VStack(alignment: .leading) {
//                HStack {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(.red)
//                        .frame(width: 50, height: 50)
//                    Text("Wasted: \(wastedItems)")
//
//                }
//
//                HStack {
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(.blue)
//                        .frame(width: 50, height: 50)
//                    Text("Saved: \(savedItems)")
//
//                }
            
        }
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(slices: [
                    (2, .red),
                    (3, .orange),
                    (4, .yellow),
                    (1, .green),
                    (5, .blue),
                    (4, .indigo),
                    (2, .purple)
                ])
        //Pie()
    }
}
