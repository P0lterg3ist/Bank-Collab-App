//
//  HomeView.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct HomeView: View {

    @State var debts = [
        Debt(money: 420.69, collector: "Mr. Tan", debtor: "me", debtor2: "Mr. Lee", appliedTags: [1, 3], daysDueFromNow: 3),
        Debt(money: 32, collector: "Ah Fan", debtor: "me", debtor2: "Mrs. Koo", appliedTags: [0], daysDueFromNow: 9)
    ]
    @State var debtsDueInAWeek = [
        Debt(money: 420.69, collector: "Mr. Tan", debtor: "me", debtor2: "Mr. Lee", appliedTags: [1, 3], daysDueFromNow: 3)
    ]
    @State var tags = [
        Tag(name: "Bill Split", icon: "square.fill", colour: Color.blue),
        Tag(name: "Normal", icon: "triangle.fill", colour: Color.green),
        Tag(name: "Insurance", icon: "dollarsign.circle", colour: Color.red),
        Tag(name: "Car", icon: "car", colour: Color.orange),
        Tag(name: "Renovation", icon: "hammer.fill", colour: Color.purple)
    ]
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $searchTerm, prompt: Text("Search for something"))
                        .padding(.leading, 30)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                }
                ScrollView(.horizontal) {
                    HStack(spacing: 7) {
                        ForEach(tags) { tag in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.5)
                                    .stroke(tag.colour, lineWidth: 1)
                                    .frame(width: 90, height: 25)
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(tag.colour)
                                    .padding(.trailing, 66)
                                Image(systemName: tag.icon)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 66)
                                    .font(.system(size: 14))
                                    .padding(.bottom, 1)
                                Text(tag.name)
                                    .foregroundColor(tag.colour)
                                    .font(.caption)
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .padding(.bottom, 10)
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
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                    ForEach(debtsDueInAWeek) { debt in
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
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
    
    func dayDifference(notUpdatedDay: Int, notUpdatedMonth: Int) -> Int {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date), month = calendar.component(.month, from: date)
        if Int(month) == 1 || Int(month) == 3 || Int(month) == 5 || Int(month) == 7 || Int(month) == 8 || Int(month) == 10 || Int(month) == 12 {
            let daysInMonth = 31
        } else if Int(month) == 2 {
            let year = calendar.component(.year, from: date)
            if Int(year) % 4 == 0 {
                if Int(year) % 100 == 0 && Int(year) % 400 != 0 {
                    let daysInMonth = 28
                } else {
                    let daysInMonth = 29
                }
            }
        } else {
            let daysInMonth = 30
        }
        return 0
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
