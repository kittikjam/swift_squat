import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {
    @Published var configuration: ExerciseConfiguration {
        didSet {
            self.saveConfiguration()
        }
    }

    @Published var displayMode: WorkoutDisplayMode {
        didSet {
            self.saveDisplayMode()
        }
    }

    @Published private(set) var sessions: [WorkoutSession]

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        // Load configuration
        if let data = defaults.data(forKey: "exercise-configuration"),
           let decodedConfig = try? JSONDecoder().decode(ExerciseConfiguration.self, from: data) {
            self.configuration = decodedConfig
        } else {
            self.configuration = ExerciseConfiguration()
        }
        
        // Load display mode
        if let data = defaults.data(forKey: "workout-display-mode"),
           let decodedMode = try? JSONDecoder().decode(WorkoutDisplayMode.self, from: data) {
            self.displayMode = decodedMode
        } else {
            self.displayMode = .guided
        }
        
        // Load sessions
        if let data = defaults.data(forKey: "workout-sessions"),
           let decodedSessions = try? JSONDecoder().decode([WorkoutSession].self, from: data) {
            self.sessions = decodedSessions
        } else {
            self.sessions = []
        }
    }

    func add(_ session: WorkoutSession) {
        var exists: Bool = false
        for existingSession in self.sessions {
            if existingSession.id == session.id {
                exists = true
                break
            }
        }
        
        if exists == true {
            return
        }
        
        self.sessions.insert(session, at: 0)
        self.saveSessions()
    }

    private func saveConfiguration() {
        if let encoded = try? JSONEncoder().encode(self.configuration) {
            self.defaults.set(encoded, forKey: "exercise-configuration")
        }
    }

    private func saveDisplayMode() {
        if let encoded = try? JSONEncoder().encode(self.displayMode) {
            self.defaults.set(encoded, forKey: "workout-display-mode")
        }
    }

    private func saveSessions() {
        if let encoded = try? JSONEncoder().encode(self.sessions) {
            self.defaults.set(encoded, forKey: "workout-sessions")
        }
    }
}