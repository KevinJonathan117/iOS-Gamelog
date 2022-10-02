//
//  HomeViewModel.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import Foundation

enum LoadingState {
    case loading
    case fail
    case empty
    case loaded
}

class HomeViewModel: ObservableObject {
    @Published var games = [Game]()
    @Published var state: LoadingState = .loading
    @Published var searchQuery: String = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.getGames()
            })
        }
    }
    
    let dataService: DataService
    
    init(dataService: DataService = AppDataService()) {
        self.dataService = dataService
    }
    
    func getGames() {
        dataService.getGames(query: searchQuery, completion: { [weak self] games, isError in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.games = games
                
                if isError {
                    self.state = .fail
                } else if games.isEmpty {
                    self.state = .empty
                } else {
                    self.state = .loaded
                }
            }
        })
    }
}
