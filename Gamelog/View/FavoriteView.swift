//
//  FavoriteView.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 09/10/22.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .fail:
                    Text("Failed to Load Data")
                case .empty:
                    Text("No Saved Favorite")
                case .loaded:
                    ListView()
                }
            }
            .navigationTitle("Gamelog")
            .toolbar {
                Button {
                    print("Navigated to Profile")
                } label: {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
            .onAppear {
                viewModel.getGames()
            }
        }
    }
}

private extension FavoriteView {
    @ViewBuilder func ListView() -> some View {
        List(viewModel.games) { game in
            NavigationLink {
                DetailView(id: Int(game.id))
            } label: {
                HStack {
                    AsyncImage(
                        url: URL(string: game.backgroundImage ?? ""),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .cornerRadius(8)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(width: 120, height: 120)
                        }
                    )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(String(game.rating))")
                            
                            Spacer()
                        }
                        
                        Text(game.name ?? "")
                            .multilineTextAlignment(.leading)
                        
                        Text(DateUtility.convertToHumanReadableDate(game.released ?? ""))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

