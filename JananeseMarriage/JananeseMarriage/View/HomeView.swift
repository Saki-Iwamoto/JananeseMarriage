//
//  HomeView.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import SwiftUI

struct HomeView: View {
    @State var animals: [String] = ["🐶", "🐱", "🐊"]
    
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(animals, id: \.self) { animal in
                        HStack {
                            Text(animal)
                                .padding(.all)
                            Spacer()
                        }
                    }
                    .onDelete(perform: delete)
                    
                    Button(action: {
                        self.isPresented = true
                    }){
                        HStack {
                            Image("AddCircle")
                            Text("入力する")
                        }
                    }
                    .sheet(isPresented: $isPresented) {
                        InputPartnerView()
                    }
                    
                    .frame(height: 50)
                }
                .navigationBarTitle(Text("結婚する人"))
            }
            
            Button(action: {
                print("結婚処理")
            }){
                Text("結婚する")
                    .foregroundColor(Color.white)
            }
            .padding(.all)
            .background(Color.gray)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.bottom)
    }
    
    /// 削除
    /// - Parameter offsets: 削除対象
    func delete(at offsets: IndexSet) {
        animals.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
