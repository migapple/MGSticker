//
//  TestView.swift
//  Postit
//
//  Created by Michel Garlandat on 07/10/2020.
//

import SwiftUI

struct TestView: View {

    @State var output: String = ""
    @State private var bgColor = Color(.yellow)
    @AppStorage("postit") var postItData: Data = Data()

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack{

            Text(output)
                .padding()

            TextEditor(text: $output)
                .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.yellow)
                .foregroundColor(.black)

            Button("Load from App Storage") {
                guard let settings = try?
                        JSONDecoder().decode(PostIt.self, from: postItData) else { return }

                output = "Text: \(settings.text) \nfgColor: \(settings.fgColorString) \nbgColor: \(settings.bgColorString) "
            }
            .padding()


            Button("Save in App Storage") {
                let settings = PostIt(text: "Michel Garlandat", fgColorString: ".black", bgColorString: ".yellow", fontSize: 8, selected: true)

                guard let postItData = try?
                        JSONEncoder().encode(settings) else { return }

                self.postItData = postItData
            }
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
