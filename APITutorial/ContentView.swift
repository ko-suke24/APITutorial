//
//  ContentView.swift
//  APITutorial
//
//  Created by RURU.jr on 2023/04/14.
//

import SwiftUI

struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    var series: String
}

struct ContentView: View {
    @State private var quotes = [Quote]()

    var body: some View {
        NavigationView {
            List(quotes, id: \.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .font(.headline)
                        .foregroundColor(Color("skyBlue"))
                    Text(quote.quote)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Quote")
            .task {
                await fetchData()
            }
        }
    }

    func fetchData() async {
//        create url
        guard let url =  URL(string: "https://breakingbadapi.com/api/quotes") else {
            print("hey man THIS URL DONE NOT WORK")
            return
        }

//        fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
        } catch {
            print("bad news ... this data isn't vaild :(")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

