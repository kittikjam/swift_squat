import Foundation

enum ExerciseVariation: String, CaseIterable, Codable, Identifiable {
    case bodyweight = "bodyweight"
    case partial = "partial"
    case box = "box"
    case assisted = "assisted"

    var id: String {
        return self.rawValue
    }

    var title: String {
        switch self {
        case .bodyweight:
            return "Bodyweight squat"
        case .partial:
            return "Partial squat"
        case .box:
            return "Box squat"
        case .assisted:
            return "Assisted squat"
        }
    }

    var isExperimental: Bool {
        if self == .box || self == .assisted {
            return true
        } else {
            return false
        }
    }
}

enum AssessmentMode: String, CaseIterable, Codable, Identifiable {
    case personal = "personal"
    case reference = "reference"
    case baseline = "baseline"

    var id: String {
        return self.rawValue
    }

    var title: String {
        let str = self.rawValue
        return str.capitalized
    }
}

enum WorkoutDisplayMode: String, CaseIterable, Codable, Identifiable {
    case minimal = "minimal"
    case guided = "guided"
    case analysis = "analysis"

    var id: String {
        return self.rawValue
    }

    var title: String {
        return self.rawValue.capitalized
    }

    var description: String {
        switch self {
        case .minimal:
            return "Camera, count, and tracking only."
        case .guided:
            return "Adds occasional personalised feedback."
        case .analysis:
            return "Shows live angles, phase, and diagnostics."
        }
    }

    var systemImage: String {
        switch self {
        case .minimal:
            return "eye"
        case .guided:
            return "sparkles"
        case .analysis:
            return "waveform.path.ecg"
        }
    }
}

struct ExerciseConfiguration: Codable, Equatable {
    var variation: ExerciseVariation = ExerciseVariation.partial
    var leftKneeTarget: Double = 120.0
    var rightKneeTarget: Double = 120.0
    var linksTargets: Bool = true
    var tolerance: Double = 5.0
    var repetitionTarget: Int = 10
    var assessmentMode: AssessmentMode = AssessmentMode.personal
    var notes: String = ""

    mutating func setLeftTarget(_ value: Double) {
        self.leftKneeTarget = value
        if self.linksTargets == true {
            self.rightKneeTarget = value
        }
    }

    mutating func setTargetsLinked(_ isLinked: Bool) {
        self.linksTargets = isLinked
        if isLinked == true {
            self.rightKneeTarget = self.leftKneeTarget
        }
    }
}