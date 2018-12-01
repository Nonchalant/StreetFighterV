struct Set: Codable {
    let name: String
    let normalMoves: [Move]
    let uniqueAttacks: [Move]?
    let normalThrows: [Move]
    let vSystem: [Move]
    let specialMoves: [Move]
    let criticalArts: [Move]
}
