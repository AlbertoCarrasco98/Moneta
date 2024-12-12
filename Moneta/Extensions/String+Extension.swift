extension String {
    func mapToCents() -> Int {
        let formattedAmount = self.replacingOccurrences(of: ",",
                                                        with: ".")
        if let amountDouble = Double(formattedAmount) {
            let amountInCents = Int((amountDouble * 100).rounded())
            return amountInCents
        } else {
            return 0
        }
    }
}
