//
//  DetailView.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    init(id: Int) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(id: id))
    }
    
    var body: some View {
        VStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .fail, .empty:
                    Text("Loading Failed")
                case .loaded:
                    ScrollView {
                        Header()
                        
                        Content()
                    }
                }
            }
            .navigationTitle("Game Detail")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getGameDetail()
                viewModel.getFavoriteStatus()
            }.toolbar {
                Button {
                    viewModel.toggleFavoriteStatus()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                }
            }
        }.alert(isPresented: $viewModel.showPopup) {
            Alert(
                title: Text(viewModel.isFavorite ? "Added to Favorite" : "Removed from Favorite"),
                message: Text("You can always check your favorited games at Favorite tab"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

private extension DetailView {
    @ViewBuilder func Header() -> some View {
        AsyncImage(
            url: URL(string: viewModel.game?.backgroundImage ?? ""),
            content: { image in
                image.resizable()
                    .frame(height: 240)
            },
            placeholder: {
                Spacer()
                
                ZStack {
                    ProgressView()
                }.frame(height: 240)
                
                Spacer()
            }
        )
    }
    
    @ViewBuilder func Content() -> some View {
        Group {
            VStack(spacing: 8) {
                Text(viewModel.game?.name ?? "")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(String(viewModel.game?.rating ?? 0))")
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Released on: \(DateUtility.convertToHumanReadableDate(viewModel.game?.released ?? ""))")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .bold()
                
                Text(viewModel.game?.website ?? "")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        guard let url = URL(string: viewModel.game?.website ?? "") else { return }
                        UIApplication.shared.open(url)
                    }
                
                Divider()
                
                Text(viewModel.game?.description?.convertHtmlToString ?? "")
            }
        }
        .padding([.top, .leading, .trailing])
    }
}
