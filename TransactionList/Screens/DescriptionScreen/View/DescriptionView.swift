//
//  DescriptionView.swift
//  TransactionList
//
//  Created by Dima Tym on 01.11.2023.
//

import SwiftUI

struct DescriptionView: View {
    @ObservedObject var viewModel: DescriptionViewModel
    
    init(viewModel: DescriptionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                buildCardView(with: viewModel.state.item.accountNumber)
                    .padding(.bottom)
                VStack(spacing: 4) {
                    buildRaw(with: "Id", description: "\(viewModel.state.item.id)")
                    Divider()
                        .padding(.leading, 16)
                    buildRaw(with: "Type", description: viewModel.state.item.type.rawValue)
                    Divider()
                        .padding(.leading, 16)
                    buildRaw(with: "Currency code", description: viewModel.state.item.currencyCode.rawValue)
                    Divider()
                        .padding(.leading, 16)
                    buildRaw(with: "Transaction purpose", description: viewModel.state.item.transactionPurpose)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.white)))
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.white)))
            }
            .shadow(color: Color(R.Color.lightBlue.rawValue).opacity(0.8), radius: 9, x: 0, y: 2)
            VStack {
                buildDescription(with: "Description", description: viewModel.state.item.description)
                    .padding(.bottom, 10)
                buildSaveButton
            }
        }
        .navigationBarTitle("Transaction details", displayMode: .inline)
        .font(.headline)
        .padding()
    }
    
    @ViewBuilder
    private func buildCardView(with number: String) -> some View {
        VStack(alignment: .center) {
            HStack {
                Text("Coin Caprice Bank")
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(.top)
                Spacer()
            }
            
            Text(number)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.title)
                .padding(.top)
            
            HStack {
                Spacer()
                Image(R.Image.masterCard.rawValue)
            }
        }
        .padding(.horizontal, 20)
        .background(
            Image(R.Image.bg.rawValue)
        )
    }
    
    @ViewBuilder
    private func buildRaw(with title: String, description: String) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .padding(.vertical)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            Spacer()
            Text(description)
                .padding(.vertical)
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private var buildSaveButton: some View {
        Button {
            hideKeyboard()
            viewModel.handle(.save)
        } label: {
            HStack {
                Spacer()
                Text("Save")
                Spacer()
            }
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .frame(height: 44)
            .background(viewModel.state.isActiveChanges ? Color(R.Color.accent.rawValue) : Color(R.Color.babyBlue.rawValue))
            .cornerRadius(12)
        }
    }
    
    @ViewBuilder
    private func buildDescription(with title: String, description: String) -> some View {
        VStack(alignment: .leading) {
            Text(title + ":")
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            HStack(alignment: .center) {
                MultilineTextField(
                    description,
                    text: .init(
                        get: {
                            description
                        },
                        set: { newValue in
                            viewModel.handle(.changeDescription(newValue))
                        }
                    )
                )
                .textFieldStyle(.plain)
                .foregroundColor(.white)
                .keyboardType(.default)
                .background(Color(R.Color.babyBlue.rawValue))
                .cornerRadius(6)
                if viewModel.state.isActiveChanges {
                    Button {
                        viewModel.handle(.changeDescription(""))
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }
            
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(viewModel: .init(item: .init(id: 1, type: .income, amount: 10.0, currencyCode: .mdl, date: "22.01.2023", accountNumber: "4444 1111 5656 7878", transactionPurpose: "Credit handling", description: "Сredit rate payment")) { _ in })
    }
}
