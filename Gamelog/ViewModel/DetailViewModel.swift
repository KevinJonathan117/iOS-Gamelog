//
//  DetailViewModel.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 02/10/22.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var game: Game? = nil
    @Published var state: LoadingState = .loading
    @Published var isFavorite: Bool = false
    @Published var showPopup: Bool = false
    
    let id: Int
    let dataService: DataService
    
    init(id: Int, dataService: DataService = AppDataService()) {
        self.id = id
        self.dataService = dataService
    }
    
    func getGameDetail() {
        dataService.getGameDetail(id: id, completion: { [weak self] game, isError in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.game = game
                
                if isError {
                    self.state = .fail
                } else if game == nil {
                    self.state = .empty
                } else {
                    self.state = .loaded
                }
            }
        })
    }
    
    func getFavoriteStatus() {
        isFavorite = dataService.getFavoriteStatus(id: id)
    }
    
    func toggleFavoriteStatus() {
        guard let game = game else { return }
        var isSuccess: Bool = false
        
        if isFavorite {
            isSuccess = dataService.deleteFavorite(game: game)
        } else {
            isSuccess = dataService.addFavorite(game: game)
        }
        
        if isSuccess {
            getFavoriteStatus()
            showPopup = true
        }
    }
}
