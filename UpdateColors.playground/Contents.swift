import UIKit

var colorsArray = [CGFloat](repeating: 0.0, count: 5)

//func updateColorPatterns() {
//
//    let color1 = CGFloat.random(in: 0.0 ... 0.99)
//    let color2 = CGFloat.random(in: 0.0 ... 0.99)
//    let color3 = CGFloat.random(in: 0.0 ... 0.99)
//    let color4 = CGFloat.random(in: 0.0 ... 0.99)
//    let color5 = CGFloat.random(in: 0.0 ... 0.99)
//
//    let color1ToCGFloat = CGFloat((String(format: "%.1f", color1) as NSString).doubleValue)
//    let color2ToCGFloat = CGFloat((String(format: "%.1f", color2) as NSString).doubleValue)
//    let color3ToCGFloat = CGFloat((String(format: "%.1f", color3) as NSString).doubleValue)
//    let color4ToCGFloat = CGFloat((String(format: "%.1f", color4) as NSString).doubleValue)
//    let color5ToCGFloat = CGFloat((String(format: "%.1f", color5) as NSString).doubleValue)
//
//    colorsArray = [color1ToCGFloat, color2ToCGFloat, color3ToCGFloat, color4ToCGFloat, color5ToCGFloat]
//}
//
//updateColorPatterns()

//func updateColorArray() {
//    for _ in 1...5 {
//        let color = CGFloat.random(in: 0.0...0.99)
//        let randomColor = CGFloat((String(format: "%.1f", color) as NSString).doubleValue)
//        colorsArray.append(randomColor)
//        print(colorsArray)
//        let colorBar = String("colorBar\(colorsArray.count)")
//        print(colorBar)
//    }
//}
//
//updateColorArray()

func mapColorArray() {
    
    colorsArray = colorsArray.map {_ in CGFloat.random(in: 0.0...0.99)}
    
   
    print(colorsArray)
}

mapColorArray()
