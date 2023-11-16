//
//  ImagePresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ImagePresentationView: View {
    
    var image: NSImage
    
    var body: some View {
        Image(nsImage: image)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    ImagePresentationView(image: .groups)
}
