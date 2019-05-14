struct Move: Codable {
    let name: String
    let startUp: String
    let active: String
    let recovery: String
    let recoveryOnHit: String
    let recoveryOnBlock: String
    let vTriggerCancelRecoveryOnHit: String
    let vTriggerCancelRecoveryOnBlock: String
    let comments: String
}
