//
//  ProfileView.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
        .toolbar {
            Button {
                viewModel.isSheetPresented.toggle()
            } label: {
                Text("Edit")
            }.sheet(isPresented: $viewModel.isSheetPresented) {
                BottomsheetContent()
            }
        }
    }
}

extension ProfileView {
    @ViewBuilder func Header() -> some View {
        Group {
            Text(viewModel.name)
                .font(.title)
            
            Text(viewModel.job)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder func About() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About Me")
                .font(.title2)
                .bold()
            
            Text(viewModel.aboutMe)
        }
    }
    
    @ViewBuilder func BottomsheetContent() -> some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("My Basic Info")) {
                        TextField(
                            "Name",
                            text: $viewModel.nameTextfield
                        )
                        .disableAutocorrection(true)
                        
                        TextField(
                            "Job",
                            text: $viewModel.jobTextfield
                        )
                        .disableAutocorrection(true)
                    }
                    
                    Section(header: Text("About Me")) {
                        if #available(iOS 16.0, *) {
                            TextField(
                                "About Me",
                                text: $viewModel.aboutMeTextfield,
                                axis: .vertical
                            )
                            .disableAutocorrection(true)
                            .lineLimit(5)
                        } else {
                            TextField(
                                "About Me",
                                text: $viewModel.aboutMeTextfield
                            )
                            .disableAutocorrection(true)
                        }
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.isSheetPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.isSheetPresented.toggle()
                        viewModel.saveProfileEdit()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
            }
        }
    }
}
