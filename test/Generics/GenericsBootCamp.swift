//
//  GenericsBootCamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/26.
//

import SwiftUI

struct GenericStringModel {
    let info: String?
    func removeInfo() ->  GenericStringModel {
        GenericStringModel(info: nil)
    }
}

struct GenericBoolModel {
    let info: Bool?
    func removeInfo() -> GenericBoolModel {
        GenericBoolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    func removeInfo() ->  GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var dataArray: GenericStringModel = GenericStringModel(info: "Hello World!")
    @Published var boolModel: GenericBoolModel = GenericBoolModel(info: true)
    @Published var genericeStringModel: GenericModel = GenericModel(info: "Hello World!")
    @Published var genericeBoolModel: GenericModel = GenericModel(info: true)
    
    
    func removeDataFromDataArray() {
        dataArray = dataArray.removeInfo()
        boolModel = boolModel.removeInfo()
        genericeBoolModel = genericeBoolModel.removeInfo()
        genericeStringModel = genericeStringModel.removeInfo()
    }
}

struct GenericsBootCamp: View {
    
    @StateObject private var gvm = GenericsViewModel()
    
    
    var body: some View {
        VStack {
            Text(gvm.dataArray.info ?? "no data")
            Text(gvm.boolModel.info?.description ?? "no data")
            Text(gvm.genericeStringModel.info ?? "no data")
            Text(gvm.genericeBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            gvm.removeDataFromDataArray()
        }
    }
}

struct GenericsBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootCamp()
    }
}
