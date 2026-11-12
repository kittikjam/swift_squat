import Foundation

struct RepetitionResult: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let sequence: Int
    let minimumLeftKneeAngle: Double
    let minimumRightKneeAngle: Double
    let duration: TimeInterval
    let trackingConfidence: Double
    let techniqueScore: Double
    let metPersonalTarget: Bool
}

struct WorkoutSession: Codable, Identifiable, Equatable {
    let id: UUID = UUID()
    let startedAt: Date
    let endedAt: Date
    let configuration: ExerciseConfiguration
    let repetitions: [RepetitionResult]

    var targetPassCount: Int {
        repetitions.filter(\.metPersonalTarget).count
    }

    var averageTechniqueScore: Double? {
        guard !repetitions.isEmpty else { return nil }
        return repetitions.map(\.techniqueScore).reduce(0, +) / Double(repetitions.count)
    }

    var averageTrackingConfidence: Double {
        guard !repetitions.isEmpty else { return 0 }
        return repetitions.map(\.trackingConfidence).reduce(0, +) / Double(repetitions.count)
    }

    var keyFeedback: String {
        guard !repetitions.isEmpty else {
            return "No complete repetitions were detected."
        }
        if targetPassCount == repetitions.count {
            return "Consistent depth across the set. Keep the same controlled tempo."
        }
        if targetPassCount >= repetitions.count / 2 {
            return "Depth became less consistent late in the set. Reset between repetitions."
        }
        return "Your personal depth target was missed often. Use a range you can control."
    }
}