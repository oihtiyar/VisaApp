//
//  AppointmentView.swift
//  VisaApp
//
//  Created by oihtiyar on 16.12.2024.
//

import SwiftUI

struct AppointmentView: View {
    @State private var countries = ["Italy", "Germany", "France", "Netherlands", "Denmark"]
    @State private var selectedCountry: String? = nil
    @State private var appointmentMessage: String = "Randevu durumu: Henüz kontrol edilmedi."
    @State private var isChecking: Bool = false
    private let scheduler = AppointmentScheduler()

    var body: some View {
        NavigationView {
            VStack {
                Text("Visa Appointment Checker")
                    .font(.largeTitle)
                    .padding()

                List(countries, id: \.self) { country in
                    Button(action: {
                        selectedCountry = country
                        checkAppointment(for: country)
                    }) {
                        Text(country)
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
                
                // Seçilen ülke için detaylı randevu bilgisi
                if let country = selectedCountry {
                    Text("Seçilen Ülke: \(country)")
                        .font(.headline)
                        .padding()
                    Text(appointmentMessage)
                        .padding()
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Ülkeler")
        }
    }
    
    // Randevu kontrol fonksiyonu
    private func checkAppointment(for country: String) {
        isChecking = true
        appointmentMessage = "Randevular kontrol ediliyor..."
        scheduler.checkForAppointment(for: country) { message in
            DispatchQueue.main.async {
                appointmentMessage = message
                isChecking = false
            }
        }
    }
}
