//
//  HomeViewModel.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import Foundation
import Combine

enum LoadingState {
    case loading
    case fail
    case empty
    case loaded
}

class HomeViewModel: ObservableObject {
    @Published var games = [Game]()
    @Published var state: LoadingState = .loading
    @Published var searchQuery: String = "" 
    
    let dataService: DataService
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: DataService = AppDataService()) {
        self.dataService = dataService
        initSearchObserver()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func initSearchObserver() {
        $searchQuery
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.getGames()
            })
            .store(in: &cancellables)
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
