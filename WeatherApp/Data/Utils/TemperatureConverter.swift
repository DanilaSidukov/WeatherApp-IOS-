
func getCurrentTemp(temp: Double?) -> String {
    var currentTempString: String
    
    if (temp != nil) {
        let tempInt = Int(temp!)
        currentTempString = String(tempInt)
    } else {
        currentTempString = "N/A"
    }
    
    return currentTempString
}

func getCurrentTempRange(min: Double?, max: Double?) -> String {
    var currentTempRangeString: String
    
    if (min != nil && max != nil) {
        let minInt = Int(min!)
        let maxInt = Int(max!)
        currentTempRangeString = "\(minInt) - \(maxInt)"
    } else {
        currentTempRangeString = "N/A"
    }
    return currentTempRangeString
}
