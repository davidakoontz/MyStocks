//
//  String+Extensions.swift
//  MyStocks
//
//  Created by David on 4/15/22.
//

import Foundation

extension String  {
    
    // e.g. $10.57
    func  prefix(withText text: String) -> String {
        return text + self
    }
    
    // e.g.  10.57%
    func postfix(withText text: String) -> String {
        return self +  text
    }
    
    // "10.57" -> 10.570000
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func inParenthese() -> String {
        return "(" + self + ")"
    }
    
    func toCurrency() -> String {
        return self.toDouble()?.toCurrencyFormat ?? "$" + self
    }
    
    // e.g. 10.57%
    func toPrecentage() -> String {
        return (self.toDouble()?.twoDecimalPlaceString.postfix(withText: "%"))!
    }
    
    // arrow.up  Unicode  ↥ U+21A5
    
    func toDeltaCurrencyWithArrow() -> String {
        let value  = self.toDouble()  ?? 0.0
        if value  < 0 {
            return "\u{2193}" + abs(value).twoDecimalPlaceString
        } else if value  > 0 {
            return "\u{2191}" + value.twoDecimalPlaceString
        } else {
            return value.twoDecimalPlaceString
        }
        
    }
}
