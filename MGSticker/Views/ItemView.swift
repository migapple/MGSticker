//
//  ItemView.swift
//  Postit
//
//  Created by Michel Garlandat on 07/10/2020.
//

import SwiftUI

struct ItemView: View {
    let fontSizes = [8,12,24,36,48]
    
    @State private var bgColor = Color.yellow
    @State private var fgColor = Color.black
    
    @AppStorage("selection") var selection = 1
    @AppStorage("text") var text = ""
    @AppStorage("fgColorString") var fgColorString = ""
    @AppStorage("bgColorString") var bgColorString = ""
    
    @State var fontSize = 12
    @State var output = ""
    
    @AppStorage("postIt") var postItData: Data = Data()
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(bgColor)
                    .foregroundColor(fgColor)
                    .font(.system(size: CGFloat(fontSize)))
            }
            
            ColorPicker("Set the background color", selection:
                Binding(get: {
                    bgColor
                }, set: { newValue in
                    bgColorString = self.updateCardColor(color: newValue)
                    bgColor = newValue
                })
            )
            .padding([.leading, .trailing])
            
            ColorPicker("Set the foreground color", selection:
                Binding(get: {
                    fgColor
                }, set: { newValue in
                    fgColorString = self.updateCardColor(color: newValue)
                    fgColor = newValue
                })
            )
            .padding([.leading, .trailing])
            
            Picker(selection:
                Binding(get: {
                    selection
                }, set: { newValue in
                    fontSize = Int(fontSizes[selection])
                    selection = newValue
                })
                , label: Text("")) {
                ForEach(0..<fontSizes.count) { index in
                    Text("\(self.fontSizes[index])")
                }
            }
        }
        .onAppear {
            if (fgColorString != "") {
                let rgbArray = fgColorString.components(separatedBy: ",")
                if let red = Double(rgbArray[0]), let green = Double(rgbArray[1]), let blue = Double(rgbArray[2]),let alpha = Double(rgbArray[3]) {
                    fgColor = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
                }
                print("Foreground color: \(fgColor)")
            }
            
            if (bgColorString != "") {
                let rgbArray = bgColorString.components(separatedBy: ",")
                if let red = Double(rgbArray[0]), let green = Double(rgbArray[1]), let blue = Double(rgbArray[2]),let alpha = Double(rgbArray[3]) {
                    bgColor = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
                }
                print("Background color: \(bgColor)")
            }
        }
    }
    
    func updateCardColor(color: Color) -> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return "\(red),\(green),\(blue),\(alpha)"
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemView()
            ItemView()
                .previewDevice("iPhone SE (1st generation)")
        }
        
    }
}

