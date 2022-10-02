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
        ScrollView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .frame(alignment: .center)
                case .fail, .empty:
                    Text("Loading Failed")
                case .loaded:
                    VStack {
                        Header()
                        
                        Content()
                    }
                }
            }
            .navigationTitle("Game Detail")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getGameDetail()
            }
        }
    }
}

private extension DetailView {
    @ViewBuilder func Header() -> some View {
//        AsyncImage(
//            url: URL(string: viewModel.game?.backgroundImage ?? ""),
//            content: { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 120, height: 120)
//                    .cornerRadius(8)
//                    .shadow(radius: 7)
//            },
//            placeholder: {
//                Spacer()
//
//                ZStack {
//                    ProgressView()
//                }.frame(width: 120, height: 120)
//
//                Spacer()
//            }
//        )
        
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
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Released on: \(viewModel.game?.released ?? "")")
                
                Text(viewModel.game?.website ?? "")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        guard let url = URL(string: viewModel.game?.website ?? "") else { return }
                        UIApplication.shared.open(url)
                    }
                
                AttributedText(viewModel.game?.description ?? "")
            }
        }
        .padding([.top, .leading, .trailing])
    }
}
