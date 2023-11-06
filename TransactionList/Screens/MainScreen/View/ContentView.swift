//
//  ContentView.swift
//  TransactionList
//
//  Created by Dima Tym on 31.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @SwiftUI.State var progress: Double
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        self.progress = 0
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    buildLoadView()
                    VStack() {
                        ForEach(viewModel.state.items, id: \.id) { transaction in
                            NavigationLink(destination: DescriptionView(viewModel: DescriptionViewModel(item: transaction) { new in
                                switch new {
                                case let .change(content):
                                    viewModel.handle(.updateTransaction(content))
                                }
                            })) {
                                buildRowView(with: transaction)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .frame(width: geometry.size.width)
                }
                
                .navigationBarTitle("Transactions", displayMode: .inline)
                .font(.headline)
            }
        }
    }
    
    @ViewBuilder
    private func buildRowView(with transaction: TransactionElement) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Account:")
                    .padding(.top)
                    .fontWeight(.semibold)
                Text("\(transaction.accountNumber)")
                    .fontWeight(.semibold)
                Text(transaction.description)
                    .padding(.top)
                    .padding(.bottom)
            }
            .foregroundColor(.blue)
            .multilineTextAlignment(.leading)
            Spacer()
            Text(transaction.date)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
        }
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        .background(RoundedRectangle(cornerRadius: 24).fill(Color(.white)))
        .shadow(color: Color(R.Color.lightBlue.rawValue).opacity(0.7), radius: 9, x: 0, y: 2)
    }
    
    @ViewBuilder
    private func buildLoadView() -> some View {
        ZStack {
            Image(R.Image.bg.rawValue)
                .shadow(color: Color(R.Color.accent.rawValue).opacity(0.5), radius: 12, x: 0, y: 5)
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 24) {
                    buildDonutView(backgroundColor: Color(R.Color.babyBlue.rawValue), foregroundColor: .white)
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Coin Caprice Bank")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.headline)
                        Text("Transaction list")
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                            .font(.caption)
                    }
                    
                }
                Button("Get Transactions") {
                    viewModel.handle(.getData)
                    withAnimation {
                        progress = 1.0
                    }
                }
                .fontWeight(.semibold)
                .frame(width: 302, height: 44, alignment: .center)
                .foregroundColor(.blue)
                .background(.white)
                .cornerRadius(22)
            }
        }
    }
    
    @ViewBuilder
    private func buildDonutView(backgroundColor: Color, foregroundColor: Color) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Circle()
                    .stroke(lineWidth: 10)
                    .fill(backgroundColor)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(foregroundColor)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                Text("\(Int(progress * 100)) %")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(transactionService: TransactionService()))
    }
}
