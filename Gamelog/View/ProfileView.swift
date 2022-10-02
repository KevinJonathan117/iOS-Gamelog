//
//  ProfileView.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            Group {
                CircleImage(image: Image("Kevin"))
                
                VStack(alignment: .leading) {
                    Header()
                    
                    Divider()
                    
                    About()
                }
            }
            .padding()
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension ProfileView {
    @ViewBuilder func Header() -> some View {
        Group {
            Text("Kevin Jonathan")
                .font(.title)
            
            Text("Associate Mobile Development Engineer (iOS) at Blibli.com")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder func About() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About Kevin")
                .font(.title2)
                .bold()
            
            Text("I am Kevin Jonathan, an ambitious mobile development engineer proficient in iOS app development and Flutter. I have 4+ years of experience in mobile application engineering and 10 months of internship in Apple Developer Academy @UC.\n\nI am currently working as an iOS Developer at Blibli.com. Kindly connect with me!")
        }
    }
}
