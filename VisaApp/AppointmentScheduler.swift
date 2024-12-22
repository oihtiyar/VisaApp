//
//  AppointmentScheduler.swift
//  VisaApp
//
//  Created by oihtiyar on 16.12.2024.
//

import Foundation
class AppointmentScheduler {
    func checkForAppointment(for country: String, completion: @escaping (String) -> Void) {
        let urlString = "https://api.schengenvisaappointments.com/api/visa-list/?country=\(country)&format=json"
        
        guard let apiUrl = URL(string: urlString) else {
            completion("Geçersiz API URL'si")
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                completion("API hatası: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion("Veri bulunamadı")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var filteredAppointments: [String] = []
                    
                    for entry in jsonResponse {
                        if let missionCountry = entry["mission_country"] as? String,
                           let appointmentDate = entry["appointment_date"] as? String,
                           let centerName = entry["center_name"] as? String,
                           appointmentDate != "null",
                           missionCountry == country,
                           centerName.contains("Istanbul") { // Sadece İstanbul ofislerini filtreliyoruz
                            filteredAppointments.append("Randevu var: \(appointmentDate) - \(centerName)")
                        }
                    }
                    
                    if filteredAppointments.isEmpty {
                        completion("İstanbul için randevu bulunamadı")
                    } else {
                        completion(filteredAppointments.joined(separator: "\n"))
                    }
                } else {
                    completion("Beklenmeyen JSON formatı")
                }
            } catch {
                completion("JSON ayrıştırma hatası: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
