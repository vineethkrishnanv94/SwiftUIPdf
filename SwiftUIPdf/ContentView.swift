//
//  ContentView.swift
//  SwiftUIPdf
//
//  Created by Vineeth Krishnan V on 09/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ShareLink("Export Pdf", item: render())
    }
    
    @MainActor func render() -> URL {
            let renderer = ImageRenderer(content:
                                            PDFView()
            )

            let url = URL.documentsDirectory.appending(path: "output.pdf")

            renderer.render { size, context in
  
                var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                    return
                }

                pdf.beginPDFPage(nil)
                context(pdf)
                pdf.endPDFPage()
                pdf.closePDF()
            }

            return url
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
