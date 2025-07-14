import SwiftUI

struct EditFieldView: View {
    @Binding var field: FieldData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Form {
                    Section(header: Text("Basic Info").foregroundColor(.cyan)) {
                        TextField("Name", text: $field.name)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                        
                        HStack {
                            Text("Quantity:")
                                .foregroundColor(.white)
                            
                            TextField("", value: $field.number, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Stepper("", value: $field.number, in: 0...999)
                                .labelsHidden()
                        }
                    }
                    
                    Section(header: Text("Next Appointment").foregroundColor(.cyan)) {
                        DatePicker("Date & Time", selection: $field.nextAppointment, displayedComponents: [.date, .hourAndMinute])
                            .accentColor(magenta)
                    }
                    
                    Section(header: Text("Daily Reminder").foregroundColor(.cyan)) {
                        Toggle(isOn: $field.isDailyReminderOn) {
                            Text("Enable Daily Reminder")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: magenta))
                        
                        if field.isDailyReminderOn {
                            DatePicker("Time", selection: $field.dailyAlertTime, displayedComponents: .hourAndMinute)
                                .accentColor(magenta)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.black)
                
                Image("heart")
                    .resizable()
                    .scaledToFit()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Save & Close")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(gradient)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .font(.largeTitle.weight(.bold))
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
        }
        .navigationTitle("Edit Entry")
        .foregroundColor(.white)
    }
}
