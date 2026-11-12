import Foundation

enum ExerciseVariation: String, CaseIterable, Codable, Identifiable {
    case bodyweight
    case partial
    case box
    case assisted

    var id: Self { self }

    var title: String {
        switch self {
        case .bodyweight: "Bodyweight squat"
        case .partial: "Partial squat"
        case .box: "Box squat"
        case .assisted: "Assisted squat"
        }
    }

    var isExperimental: Bool {
        self == .box || self == .assisted
    }
}

enum AssessmentMode: String, CaseIterable, Codable, Identifiable {
    case personal
    case reference
    case baseline

    var id: Self { self }

    var title: String {
        rawValue.capitalized
    }
}

enum WorkoutDisplayMode: String, CaseIterable, Codable, Identifiable {
    case minimal
    case guided
    case analysis

    var id: Self { self }

    var title: String {
        rawValue.capitalized
    }

    var description: String {
        switch self {
        case .minimal: "Camera, count, and tracking only."
        case .guided: "Adds occasional personalised feedback."
        case .analysis: "Shows live angles, phase, and diagnostics."
        }
    }

    var systemImage: String {
        switch self {
        case .minimal: "eye"
        case .guided: "sparkles"
        case .analysis: "waveform.path.ecg"
        }
    }
}

struct ExerciseConfiguration: Codable, Equatable {
    var variation: ExerciseVariation = .partial
    var leftKneeTarget = 120.0
    var rightKneeTarget = 120.0
    var linksTargets = true
    var tolerance = 5.0
    var repetitionTarget = 10
    var assessmentMode: AssessmentMode = .personal
    var notes = ""

    mutating func setLeftTarget(_ value: Double) {
        leftKneeTarget = value
        if linksTargets {
            rightKneeTarget = value
        }
    }

    mutating func setTargetsLinked(_ isLinked: Bool) {
        linksTargets = isLinked
        if isLinked {
            rightKneeTarget = leftKneeTarget
        }
    }
}
