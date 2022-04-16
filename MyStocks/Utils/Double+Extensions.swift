//
//  Double+Extensions.swift
//  MyStocks
//
//  Created by David on 4/15/22.
//

import Foundation

extension Double {
    
    var  toString:  String {
        return String(self)
    }
    var twoDecimalPlaceString: String {
        return String(format: "%.2f", self)     // 10.57
    }
    
    var toCurrencyFormat: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current       // USA
        formatter.numberStyle =  .currency      // $10.57
        if let value =  formatter.string(from: self as NSNumber) {
            return value
        } else {
            return twoDecimalPlaceString        // for USA dollar.cents as error default
        }
    }
    
    var toPercentageFormat: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current       // USA
        formatter.numberStyle =  .percent      // $10.57
        formatter.maximumFractionDigits = 2
        if let value =  formatter.string(from: self as NSNumber) {
            return value
        } else {
            return twoDecimalPlaceString        // for USA dollar.cents as error default
        }
    }
}
