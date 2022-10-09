//
//  ProfileViewModel.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 09/10/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var isSheetPresented = false
    @Published var name = ""
    @Published var job = ""
    @Published var aboutMe = ""
    
    //Textfield values
    @Published var nameTextfield = ""
    @Published var jobTextfield = ""
    @Published var aboutMeTextfield = ""
    
    let dataService: DataService
    
    init(dataService: DataService = AppDataService()) {
        self.dataService = dataService
        LocalStorage.initDefaultProfileInfo()
        getProfileInfo()
    }
    
    func getProfileInfo() {
        name = LocalStorage.getValue(key: "name") ?? ""
        job = LocalStorage.getValue(key: "job") ?? ""
        aboutMe = LocalStorage.getValue(key: "aboutMe") ?? ""
        
        nameTextfield = name
        jobTextfield = job
        aboutMeTextfield = aboutMe
    }
    
    func setProfileInfo() {
        LocalStorage.setValue(key: "name", value: nameTextfield)
        LocalStorage.setValue(key: "job", value: jobTextfield)
        LocalStorage.setValue(key: "aboutMe", value: aboutMeTextfield)
        
        getProfileInfo()
    }
}
