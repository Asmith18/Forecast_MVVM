//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by adam smith on 2/14/22.
//

import Foundation

protocol DayDetailViewDelegate: DayDetailsViewController {
    func updateViews()
}

class DayDetailViewModel {
    
    //MARK: - Properties
    
    var forcastData: TopLevelDictionary?
    var days: [Day] {
        self.forcastData?.days ?? []
    }
    
    private weak var delegate: DayDetailViewDelegate?
    private let networkingController: NetworkingController
    
    init(delegate: DayDetailViewDelegate, networkingController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForcastData()
    }
    
    private func fetchForcastData() {
        NetworkingController.fetchDays { result in
            
            switch result {
            case .success(let forcastData):
                self.forcastData = forcastData
                self.delegate?.updateViews()
            case .failure(let error):
                print("Error fetching the data!", error.errorDescription!)
            }
        }
    }
}
