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
        var count = 0
        for rep in repetitions {
            if rep.metPersonalTarget {
                count += 1
            }
        }
        return count
    }

    var averageTechniqueScore: Double? {
        if repetitions.isEmpty {
            return nil
        }
        
        var totalScore: Double = 0.0
        for rep in repetitions {
            totalScore += rep.techniqueScore
        }
        return totalScore / Double(repetitions.count)
    }

    var averageTrackingConfidence: Double {
        if repetitions.isEmpty {
            return 0.0
        }
        
        var totalConfidence: Double = 0.0
        for rep in repetitions {
            totalConfidence += rep.trackingConfidence
        }
        return totalConfidence / Double(repetitions.count)
    }

    var keyFeedback: String {
        if repetitions.isEmpty {
            return "No complete repetitions were detected."
        }
                
        if targetPassCount == repetitions.count {
            return "Consistent depth across the set. Keep the same controlled tempo."
        } else if targetPassCount >= repetitions.count / 2 {
            return "Depth became less consistent late in the set. Reset between repetitions."
        } else {
            return "Your personal depth target was missed often. Use a range you can control."
        }
    }
}