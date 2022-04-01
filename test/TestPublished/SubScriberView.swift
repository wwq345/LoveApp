//
//  SubScriberView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/23.
//

import SwiftUI
import Combine

class SubScribeViewModel: ObservableObject{
    @Published var count: Int = 0
    @Published var textField: String = ""
    @Published var textIsValid: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    var timer: AnyCancellable?
    
    init(){
        setupTimer()
        addTextFieldSubScriber()
    }
    
    func addTextFieldSubScriber(){
        $textField
            .map { (text) -> Bool in
                if text.count > 3{
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isvalid) in
                self?.textIsValid = isvalid
            })
            .store(in: &cancellables)
    }
    
    func setupTimer(){
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                self?.count += 1
                
                if self?.count ?? 0 >= 10{
                    self?.timer?.cancel()
                }
            }
//            .store(in: &cancellable)
    }
    
}


struct SubScriberView: View {
    @StateObject var svm: SubScribeViewModel = SubScribeViewModel()
    var body: some View {
        
        VStack {
            Text("\(svm.count)")
                .font(.largeTitle)
            
            Text(svm.textIsValid.description)
            
            TextField("Seconds Here", text: $svm.textField)
                .background(Color.red.opacity(0.6))
        }
        .frame(width: 300, height: 300)
    }
}

struct SubScriberView_Previews: PreviewProvider {
    static var previews: some View {
        SubScriberView()
    }
}
