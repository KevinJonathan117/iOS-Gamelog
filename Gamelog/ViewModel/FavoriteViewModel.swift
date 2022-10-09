//
//  FavoriteViewModel.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 09/10/22.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var games = [GameItem]()
    @Published var state: LoadingState = .loading
    
    let dataService: DataService
    
    init(dataService: DataService = AppDataService()) {
        self.dataService = dataService
    }
    
    func getGames() {
        let gameList = dataService.getFavoriteGameList()
        
        self.games = gameList
        
        if games.isEmpty {
            self.state = .empty
        } else {
            self.state = .loaded
        }
    }
}

