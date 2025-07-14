//
//  Untitled.swift
//  MediChecker
//
//  Created by Rob Mihalko on 2025/07/13.
//

import SwiftUI

struct FieldData: Identifiable {
    let id = UUID()
    var name: String = "New Medicine"
    var number: Int = 0
    
    var nextAppointment: Date = FieldData.startOfCurrentHour()
    var dailyAlertTime: Date = FieldData.startOfCurrentHour()
    
    var isDailyReminderOn: Bool = false
    
    static func startOfCurrentHour() -> Date {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        return calendar.date(from: DateComponents(
            year: components.year,
            month: components.month,
            day: components.day,
            hour: components.hour,
            minute: 0
        )) ?? now
    }
}

struct FieldCard: View {
    @Binding var field: FieldData
    
    var onDelete: () -> Void
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack {
            NavigationLink(destination: EditFieldView(field: $field)) {
                Image(systemName: "pills.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.clear)
                    .background(
                        gradient.mask(
                            Image(systemName: "pills.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        )
                    )
            }
            
            VStack {
                Text(field.name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                Text("Qty: \(field.number)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
            }
            
            NavigationLink(destination: EditFieldView(field: $field)) {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            
            Button {
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            .alert("Are you sure you want to delete \(field.name)?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    onDelete()
                }
                Button("Cancel", role: .cancel) {}
            }
            
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
    }
}
