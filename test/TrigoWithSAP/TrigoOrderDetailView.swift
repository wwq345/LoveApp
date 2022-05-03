//
//  TrigoOrderDetailView.swift
//  IRSSDemo
//
//  Created by i564206 on 2022/4/28.
//

//import SwiftUI
//
//struct TrigoOrderDetailView: View {
//    @StateObject var viewModel: IRSSOrderDetailViewModel = IRSSOrderDetailViewModel()
//    var orderNumber: String
//    var body: some View {
//        ZStack {
//            Color(.sRGB, red: 0 / 255 , green: 30 / 255, blue: 93 / 255, opacity: 1)
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                TrigoDetailHeaderView(time: viewModel.orderDetail?.metadata?.createdAt ?? "Unknown DateFormat....", receiptId: viewModel.orderDetail?.id ?? "")
//                    .padding(.top, 96)
//                    .padding(.bottom, 32)
//                
//                
//                ScrollView(showsIndicators: false) {
//                    ForEach(viewModel.orderDetail?.productList ?? [], id: \.productId) { product in
//                        TrigoDetailCardView(productName: product.displayName, quantity: product.quantity, price: product.displayPrice)
//                            .padding(.bottom, 12)
//                    }
//                }
//                
//                Spacer()
//                
//                TrigoDetailBottomView()
//                    .environmentObject(self.viewModel)
//                    .padding(.bottom, 42)
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .onAppear {
//                IRSSLoadingUtil.startScreenLoading()
//                viewModel.getOrderDetail(receiptId: orderNumber) { errorMsg in
//                    IRSSLoadingUtil.stopScreenLoading()
//                    if !(errorMsg?.isEmpty ?? true) {
//                        IRSSBanner.showError(title: "Error occured", subtitle: errorMsg ?? "")
//                    }
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Image("trigo")
//                    .resizable()
//                    .frame(width: 63, height: 31)
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct TrigoOrderDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrigoOrderDetailView(orderNumber: "0")
//    }
//}
//
//
//struct TrigoDetailHeaderView: View {
//    var time: String = ""
//    var receiptId: String = ""
//    var body: some View {
//        VStack {
//            Text("Receipt")
//                .font(Font.sap72(weight: .bold, size: 44))
//                .foregroundColor(.white)
//            Text(time.transformMultipleFormat(dateFormat: "dd/M/yyyy | HH:mm") ?? "Unknown DateFormat....")
//                .font(Font(UIFont.preferredFioriFont(fixedSize: 12, weight: .medium)))
//                .foregroundColor(.white)
//                .padding(.top, 12)
//            HStack {
//                Image(systemName: "rectangle.portrait.on.rectangle.portrait")
//                    .foregroundColor(.white)
//                Text(receiptId)
//                    .font(Font(UIFont.preferredFioriFont(fixedSize: 12, weight: .medium)))
//                    .foregroundColor(.white)
//            }
//        }
//    }
//}
//
//struct TrigoDetailBottomView: View {
//    @EnvironmentObject var viewModel: IRSSOrderDetailViewModel
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading,spacing: 8) {
//                Text("Subtotal")
//                    .font(Font.sap72(weight: .bold, size: 16))
//                    .foregroundColor(.white)
//                Text("Sales Tax")
//                    .font(Font.sap72(weight: .bold, size: 16))
//                    .foregroundColor(.white)
//                Text("Total")
//                    .font(Font.sap72(weight: .bold, size: 24))
//                    .foregroundColor(.white)
//            }
//            .padding(.leading, 16)
//            Spacer()
//            VStack(alignment: .trailing, spacing: 8) {
//                Text("\(viewModel.getHistorySummary()?.subtotal ?? "")")
//                    .font(Font.sap72(weight: .bold, size: 16))
//                    .foregroundColor(.white)
//                Text("\(viewModel.getHistorySummary()?.salesTax ?? "")")
//                    .font(Font.sap72(weight: .bold, size: 16))
//                    .foregroundColor(.white)
//                Text("\(viewModel.getHistorySummary()?.total ?? "")")
//                    .font(Font.sap72(weight: .bold, size: 24))
//                    .foregroundColor(.red)
//            }
//            .padding(.trailing, 16)
//            .padding(.bottom, 10)
//        }
//    }
//}
//
//struct TrigoDetailCardView: View {
//    var productName: String = ""
//    var quantity: Int = 0
//    var price: String = ""
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(productName)
//                    .font(Font(UIFont.preferredFioriFont(fixedSize: 14, weight: .medium)))
//                Text("SKU 7783238932")
//                    .font(Font(UIFont.preferredFioriFont(fixedSize: 14, weight: .medium)))
//                    .foregroundColor(Color(.sRGB, red: 131 / 255, green: 150 / 255, blue: 168 / 255, opacity: 1))
//                HStack {
//                    Text("Qty")
//                    Text("\(quantity) unit")
//                }
//            }
//            Spacer()
//            Text(price)
//        }
//        .padding(.horizontal)
//        .frame(width: UIScreen.main.bounds.width - 16 , height: 104)
//        .background(Color.white)
//        .cornerRadius(10)
//    }
//}

//@discardableResult func getOrderHistory(errorHandler: ((String?) -> ())? = nil, refreshing: Bool = false) async -> [IRSSOrderHistoryItem] {
//    self.turnPageAvailable = false
//    self.pageNum += 1
//    if self.firstLoad || refreshing {
//        self.pageNum = 0
//        self.allLoaded = false
//    }
//
//    do {
//        return await withCheckedContinuation({
//            (continuation: CheckedContinuation<[IRSSOrderHistoryItem], Never>) in
//            orderHistoryService.getOrderHistory(pageNum: self.pageNum, pageSize: self.pageSize) { (result) in
//                switch result {
//                case .success(let data):
//                    if data.count < self.pageSize {
//                        self.allLoaded = true
//                    }
//                    if self.firstLoad || refreshing {
//                        self.orderItems = data
//                    }
//                    else {
//                        self.orderItems += data
//                    }
//                    errorHandler?(nil)
//                case .failure(let error):
//                    errorHandler?(error.description)
//                }
//                self.turnPageAvailable = true
//                self.firstLoad = false
//                continuation.resume(returning: self.orderItems)
//            }
//        })
//    }
//}
