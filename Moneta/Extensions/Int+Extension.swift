extension Int {
    func mapToEur() -> String {
        let amountInEur = Double(self) / 100
        if amountInEur == Double(Int(amountInEur)) {
            return String(Int(amountInEur))
        } else {
            return String(format: "%.2f",
                          amountInEur)
        }
    }
}
