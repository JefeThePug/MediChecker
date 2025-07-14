//
//  ContentView.swift
//  MediChecker
//
//  Created by Rob Mihalko on 2025/07/13.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    @State private var fields: [FieldData] = [FieldData()]
//    var gradient = LinearGradient(colors: [
//        Color(red: 1.0, green: 0.0, blue: 0.6),
//        .cyan
//    ], startPoint: .leading, endPoint: .trailing)
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    Color.black
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // Logo
                        HStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height * 0.15)
                            
                            ZStack {
                                Text("Medicine Inventory")
                                    .font(.largeTitle.weight(.bold))
                                    .multilineTextAlignment(.center)
                                    .overlay(gradient)
                                    .mask(Text("Medicine Inventory")
                                        .font(.largeTitle.weight(.bold))
                                        .multilineTextAlignment(.center)
                                    )
                                    .blur(radius: 6)
                                
                                Text("Medicine Inventory")
                                    .font(.largeTitle.weight(.medium))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Scroll
                        ScrollView {
                            VStack(alignment: .leading, spacing: 15) {
                                ForEach($fields) { $field in
                                    if let index = fields.firstIndex(where: { $0.id == field.id }) {
                                        FieldCard(field: $fields[index]) {
                                            fields.remove(at: index)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(height: geo.size.height * 0.5)
                        .clipped()
                        .padding()
                        .background(gradient)
                        .cornerRadius(30)
                        
                        // Button
                        ZStack {
                            Image("heart")
                                .resizable()
                                .scaledToFill()
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    fields.append(FieldData())
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(gradient)
                                            .frame(width: 70, height: 70)
                                        
                                        Image(systemName: "pills.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.black)
                                    }
                                }
                                Spacer()
                                
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
