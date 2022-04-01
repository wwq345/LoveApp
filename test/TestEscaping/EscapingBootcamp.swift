//
//  EscapingBootcamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/27.
//

import SwiftUI

class EscapingViewModel: ObservableObject{
    @Published var text: String = "Hello"
    
    func getData(){
//        let newData = downloadData()
//        text = newData
        downloadData4 { [weak self](returneddata) in
            self?.text = returneddata.data ?? ""
        }
    }
    
    func downloadData() -> String{
        return "New Data!"
    }
    
    func downloadData2(completion: (_ data: String) -> Void){
        completion("New Data2")
    }
    
    func downloadData3(completion: @escaping (_ data: String) -> () ){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion("New Data3")
        }
    }
    
    func downloadData4(completion: @escaping (DownloadResult) -> () ){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = DownloadResult(data: "New Data4")
            completion(result)
        }
    }
}

struct DownloadResult{
    let data: String?
}

struct EscapingBootcamp: View {
    @StateObject var evm = EscapingViewModel()
    var body: some View {
        Button {
            evm.getData()
        } label: {
            Text(evm.text)
                .font(.largeTitle)
        }

    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
