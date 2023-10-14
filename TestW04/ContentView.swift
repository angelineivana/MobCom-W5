//
//  ContentView.swift
//  TestW04
//  Angeline Ivana - 0706022110021
//

import SwiftUI

struct ContentView: View {
    
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    
    @State private var angkaRandom = Int.random(in: 0...9)
    @State private var cekAngka: [Int] = []
//    @State private var angkaSebelum: Int?
    @State private var jawabanInput: Int?
    @State private var score = 0
    @State private var popUpEnd = false
    @State private var alert = ""
    @State private var round = 0
    
    func cekJawaban(_ jawaban: Int){
        if jawaban == angkaRandom {
            score += 1
        }
        jawabanInput = jawaban
        lanjutGame()
    }
    
    func lanjutGame() {
        cekAngka.append(angkaRandom)
        round += 1
        if round < 10 {
//            angkaSebelum = angkaRandom
            repeat {
                angkaRandom = Int.random(in: 0..<10)
            } while cekAngka.contains(angkaRandom)
        } else {
            if score == 10 {
                alert = "Selamat! Anda menang!"
            } else {
                alert = "Total Benar = \(score)\nTotal Salah = \(10 - score)"
            }
            popUpEnd = true
            round = 0
            score = 0
            cekAngka.removeAll()
        }
        
        jawabanInput = nil
    }
    
    var body: some View {
        ZStack{
            Color.mint
                .ignoresSafeArea()
            VStack{
                Text("Pilih Bendera dari Negara : ")
                    .foregroundStyle(.black)
                Text(asean[angkaRandom])
                    .foregroundStyle(.black)
                Text("Score : \(score)")
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
            }
        }
        
        HStack{
            Spacer()
            VStack{
                ForEach(0..<5) { number in
                    Button(action: {cekJawaban(number)}) {
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                }
            }
            Spacer()
            VStack{
                ForEach(5..<10) { number in
                    Button(action: {cekJawaban(number)}) {
                        Image(asean[number])
                            .resizable()
                            .frame(width:105,height: 65)
                    }
                }
            }
            Spacer()
            
//            .alert(isPresented: $popUp) {
//                Alert(title: Text(alert), dismissButton: .default(Text("Next"), action: {lanjutGame()
//                }))
//            }
            
            .alert(isPresented: $popUpEnd) {
                Alert(title: Text(alert), dismissButton: .default(Text("Restart"), action: {
                    lanjutGame()
                    round = 0
                    cekAngka.removeAll()
                }))
            }
        }
    }
}

#Preview {
    ContentView()
}
