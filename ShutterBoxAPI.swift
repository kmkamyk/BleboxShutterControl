//
//  ShutterBoxAPI.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import Foundation
import Combine

class ShutterBoxAPI: ObservableObject {
    @Published var shutters: [Shutter] = []
    private let fileURL: URL
    private var timer: AnyCancellable?

    init() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = documentDirectory.appendingPathComponent("shutters.json")
    }

    func fetchPositions() {
        for shutter in shutters {
            fetchPosition(for: shutter) { position in
                if let index = self.shutters.firstIndex(where: { $0.id == shutter.id }) {
                    self.shutters[index].position = position
                }
            }
        }
    }

    func fetchPosition(for shutter: Shutter, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "\(shutter.baseURL)/state") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let json = try? JSONDecoder().decode(ShutterStateResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(json.shutter.currentPos.position)
                }
            }
        }
        task.resume()
    }

    func setPosition(for shutter: Shutter, position: Int) {
        guard let url = URL(string: "\(shutter.baseURL)/s/p/\(position)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response if needed
        }
        task.resume()
    }

    func saveShutters() {
        let shuttersToSave = shutters.map { SavedShutter(baseURL: $0.baseURL) }
        do {
            let data = try JSONEncoder().encode(shuttersToSave)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save shutters: \(error)")
        }
    }

    func loadShutters() {
        do {
            let data = try Data(contentsOf: fileURL)
            let savedShutters = try JSONDecoder().decode([SavedShutter].self, from: data)
            shutters = savedShutters.map { Shutter(baseURL: $0.baseURL) }
            fetchPositions()
        } catch {
            print("Failed to load shutters: \(error)")
        }
    }

    func removeShutter(at index: Int) {
        shutters.remove(at: index)
        saveShutters()
    }

    func startAutoRefresh() {
        timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.fetchPositions()
        }
    }

    func stopAutoRefresh() {
        timer?.cancel()
        timer = nil
    }
}

struct Shutter: Identifiable {
    let id = UUID()
    let baseURL: String
    var position: Int = 0
}

struct SavedShutter: Codable {
    let baseURL: String
}

struct ShutterStateResponse: Codable {
    let shutter: ShutterState
}

struct ShutterState: Codable {
    let state: Int
    let currentPos: ShutterPosition
    let desiredPos: ShutterPosition
    let favPos: ShutterPosition
}

struct ShutterPosition: Codable {
    let position: Int
    let tilt: Int
}
