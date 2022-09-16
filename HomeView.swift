//
//  HomeView.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI
import WrappingHStack

struct HomeView: View {

    @State var debts = [
        Debt(money: 420.69, collector: "Mr. Tan", debtor: "me", debtor2: "Mr. Lee", appliedTags: [1, 3]),
        Debt(money: 32, collector: "Ah Fan", debtor: "me", debtor2: "Mrs. Koo", appliedTags: [0])
    ]
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    
    var body: some View {
        NavigationView {
            List {
                TextField("", text: $searchTerm, prompt: Text("Search for something"))
                    .padding(.leading, 30)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    )
                Section {
                    WrappingHStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12.5)
                                .stroke(.blue, lineWidth: 1)
                                .frame(width: 80, height: 25)
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                                .padding(.trailing, 56)
                            Image(systemName: "square.fill")
                                .foregroundColor(.white)
                                .padding(.trailing, 56)
                                .font(.system(size: 14))
                                .padding(.bottom, 1)
                            Text("Bill Split")
                                .foregroundColor(.blue)
                                .font(.caption)
                                .padding(.leading, 20)
                        }
                    }
                }
                Section(header: Text("OUTSTANDING")) {
                    ForEach(debts) { debt in
                        Button {
                            showTransactionDetailsSheet.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(debt.collector)
                                        .foregroundColor(.black)
                                    Text("\(debt.debtor), \(debt.debtor2) - Tag name")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", debt.money))
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailsView()
                        }
                    }
                }
            }
                .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
