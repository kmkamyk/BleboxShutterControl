//
//  ContentView.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var api = ShutterBoxAPI()
    @State private var newShutterURL = ""

    var body: some View {
        VStack {
            Text("ShutterBox Control")
                .font(.headline)
                .padding()
            List {
                ForEach(api.shutters.indices, id: \.self) { index in
                    let shutter = api.shutters[index]
                    VStack {
                        HStack {
                            Text("\(shutter.baseURL.uppercased().replacingOccurrences(of: "HTTP://", with: "")): \(shutter.position)")
                            Slider(value: Binding(
                                get: { Double(api.shutters[index].position) },
                                set: { newPosition in
                                    updatePosition(shutter: shutter, newPosition: Int(newPosition))
                                }
                            ), in: 0...100)
                            .padding()
                            Button(action: {
                                api.removeShutter(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding()
                    }
                    .onAppear {
                        api.fetchPosition(for: shutter) { position in
                            api.shutters[index].position = position
                        }
                    }
                }
            }

            HStack {
                TextField("New Shutter URL", text: $newShutterURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add Shutter") {
                    if let url = URL(string: newShutterURL) {
                        let newShutter = Shutter(baseURL: url.absoluteString)
                        api.shutters.append(newShutter)
                        api.saveShutters()
                        newShutterURL = ""
                        // Fetch position for the new shutter
                        api.fetchPosition(for: newShutter) { position in
                            if let index = api.shutters.firstIndex(where: { $0.id == newShutter.id }) {
                                api.shutters[index].position = position
                            }
                        }
                    }
                }
                .disabled(newShutterURL.isEmpty)
            }
            .padding()
        }
        .frame(width: 400, height: 330)
        .onAppear {
            api.loadShutters()
            api.startAutoRefresh()
        }
        .onDisappear {
            api.stopAutoRefresh()
        }
    }

    func updatePosition(shutter: Shutter, newPosition: Int) {
        if let index = api.shutters.firstIndex(where: { $0.id == shutter.id }) {
            api.shutters[index].position = newPosition
            api.setPosition(for: api.shutters[index], position: newPosition)
        }
    }
}
