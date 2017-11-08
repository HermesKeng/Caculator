//
//  CurrencyExchanger.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 06/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import Foundation

class CurrencyExchanger{
    
    private var money:Double
    
    init?(money:Double) {
        self.money = money
    }
    
    func setMoney(dollars:Double){
        self.money = dollars
    }
    
    func moneyTransform(fromCountry:String,toCountry:String) -> Double {
        
        var usDollar:Double?;
        var transformedDollar:Double!;
        switch fromCountry {
        case "🇨🇳CNY":
            usDollar = self.money * 0.15
        case "🇪🇺EUR":
            usDollar = self.money * 1.15857
        case "🇭🇰HKD":
            usDollar = self.money * 0.128159
        case "🇹🇼TWD":
            usDollar = self.money * 0.0331148
        case "🇺🇸USD":
            usDollar = self.money
        default:
            break
        }
        
        if let tempMoney = usDollar{
            switch toCountry {
            case "🇨🇳CNY":
                transformedDollar = tempMoney * 6.63389
            case "🇪🇺EUR":
                transformedDollar = tempMoney * 0.863122
            case "🇭🇰HKD":
                transformedDollar = tempMoney * 7.80273
            case "🇹🇼TWD":
                transformedDollar = tempMoney * 30.2005
            case "🇺🇸USD":
                transformedDollar = tempMoney
            default:
                break
            }
        }
        
        return (transformedDollar*100).rounded()/100
    }
    
}
