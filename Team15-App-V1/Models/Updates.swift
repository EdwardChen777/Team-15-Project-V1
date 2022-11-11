//
//  Updates.swift
//  Team15-App-V1
//
//  Created by Edward Chen on 11/8/22.
//

import Foundation

class Updates: ObservableObject {
//  var temp: SECTransactions.transactions
  @Published var transactions: [updateData] = []
  @Published var searchText : String = ""
  @Published var filteredTransactions: [updateData] = []
  
  
      }
      
      // Decode the JSON here
    //  guard let sec_list = try? JSONDecoder().decode(SECTransactions.self, from: sec_data) else {
    //    print("Error: Couldn't decode data into a result")
    //    return
    //  }
    init () {
      do {
        let sec_list = try JSONDecoder().decode(SECTransactions.self, from: sec_data)
        let temp = sec_list.transactions
        for value in temp {
          let filedAt = value.filedAt
          // need to unwrap
//          let symbol = value.issuer?.tradingSymbol
//          var symbol = value.issuer.tradingSymbol ?? ""
//          let shares = 0
//          let pricePerShare = 0
//          if let issuer = value.issuer {
//            let symbol = issuer.tradingSymbol
//          } else {
//            let symbol = ""
//          }
          if let derivativeTable = value.derivativeTable {
            if let derivativeTransaction = derivativeTable.transactions {
              if let first = derivativeTransaction.first {
                if let amount = first.amounts {
                  let shares = amount.shares ?? Float(0)
                  let pricePerShare = amount.pricePerShare ?? Float(0)
                  if let issuer = value.issuer {
                    let symbol = issuer.tradingSymbol ?? ""
                    self.transactions.append(updateData(filedAt: filedAt, symbol: symbol, shares: shares, pricePerShare: pricePerShare))
                  }
                } else {
                  let shares = Float(0)
                  let pricePerShare = Float(0)
                  if let issuer = value.issuer {
                    let symbol = issuer.tradingSymbol ?? ""
                    self.transactions.append(updateData(filedAt: filedAt, symbol: symbol, shares: shares, pricePerShare: pricePerShare))
                  }
                }
              } else {
                let shares = Float(0)
                let pricePerShare = Float(0)
                if let issuer = value.issuer {
                  let symbol = issuer.tradingSymbol ?? ""
                  self.transactions.append(updateData(filedAt: filedAt, symbol: symbol, shares: shares, pricePerShare: pricePerShare))
                }
              }
            } else {
              let shares = Float(0)
              let pricePerShare = Float(0)
              if let issuer = value.issuer {
                let symbol = issuer.tradingSymbol ?? ""
                self.transactions.append(updateData(filedAt: filedAt, symbol: symbol, shares: shares, pricePerShare: pricePerShare))
              } 
            }
          } else {
            let shares = Float(0)
            let pricePerShare = Float(0)
            if let issuer = value.issuer {
              let symbol = issuer.tradingSymbol ?? ""
              self.transactions.append(updateData(filedAt: filedAt, symbol: symbol, shares: shares, pricePerShare: pricePerShare))
            }
          }
          
//          let shares = value.derivativeTable?.transactions?.first?.amounts?.shares
//          let pricePerShare = value.derivativeTable?.transactions?.first?.amounts?.pricePerShare
//          let sharesOwned = value.derivatetiveTable?.transactions?.first.postTransactionAmounts?.sharesOwnedFollowingTransaction
//          let valueOwned = value.derivatetiveTable?.transactions?.first.postTransactionAmounts?.valueOwnedFollowingTransaction
//          self.transactions.append(updateData(String: filedAt, String: symbol, Float: shares, Float: pricePerShare, Float: sharesOwned, Float: valueOwned))

        }
      }
      catch {
        print("\(error)")
      }
    }
    sec.resume()
  }

  
  func search(searchText: String) {
    self.filteredTransactions = self.transactions.filter { transaction in
      return transaction.symbol.lowercased().contains(searchText.lowercased())
    }
  }
}

struct updateData: Identifiable{
  var filedAt: String
  var symbol: String
  var shares: Float
  var pricePerShare: Float
//  var sharesOwned: Float
//  var valueOwned: Float
  var id = UUID()    // To conform to Identifialbe protocol

  init(filedAt: String, symbol: String, shares: Float, pricePerShare: Float) {
      self.filedAt = filedAt
      self.symbol = symbol
      self.shares = shares
      self.pricePerShare = pricePerShare
//      self.sharesOwned = sharesOwned
//      self.valueOwned = valueOwned
  }

}


struct SECTransactions: Codable {
  let transactions: [SECTransaction]

  enum CodingKeys : String, CodingKey {
    case transactions
  }

}

struct SECTransaction: Identifiable, Codable {
  var id  = UUID()
  let filedAt: String
  let issuer: Issuer?
  let dateOfOriginalSubmission: String?
  let reportingOwner: ReportingOwner?
  let nonDerivativeTable: NonDerivativeTable?
  let derivativeTable: DerivativeTable?
  let footnotes: [Footnote]?
  let remarks: String?

  enum CodingKeys : String, CodingKey {
    case filedAt
    case issuer
    case dateOfOriginalSubmission
    case reportingOwner
    case nonDerivativeTable
    case derivativeTable
    case footnotes
    case remarks
  }
}

struct Issuer: Codable {
  let name: String?
  let tradingSymbol: String?
  
  enum CodingKeys : String, CodingKey {
    case name
    case tradingSymbol
  }
}

struct ReportingOwner: Codable {
  let name: String?
  let relationship: Relationship?
  
  enum CodingKeys: String, CodingKey {
    case name
    case relationship
  }
}

struct Relationship: Codable {
  let isDirector: Bool?
  let isOfficer: Bool?
  let officerTitle: String?
  let isTenPercentOwner: Bool?
  let isOther: Bool?
  let otherText: String?
  
  enum CodingKeys: String, CodingKey {
    case isDirector
    case isOfficer
    case officerTitle
    case isTenPercentOwner
    case isOther
    case otherText
  }
}

struct NonDerivativeTable: Codable {
  let transactions: [SecurityTransaction]?
  let holdings: [Holdings]?
  
  enum CodingKeys: String, CodingKey {
    case transactions
    case holdings
  }
}

struct DerivativeTable: Codable {
  let transactions: [SecurityTransaction]?
  let holdings: [Holdings]?
  
  enum CodingKeys: String, CodingKey {
    case transactions
    case holdings
  }
}

struct SecurityTransaction: Codable {
  let securityTitle: String?
  let transactionDate: String?
  let deemedExecutionDate: String?
  let coding: Coding?
  let timeliness: String?
  let amounts: Amounts?
  let postTransactionAmounts: PostTransactionAmounts?
  let ownershipNature: OwnershipNature?
  
  enum CodingKeys: String, CodingKey {
    case securityTitle
    case transactionDate
    case deemedExecutionDate
    case coding
    case timeliness
    case amounts
    case postTransactionAmounts
    case ownershipNature
  }
}

struct Coding: Codable {
  let formType: String?
  let code: String?
  let equitySwapInvolved: Bool?
  
  enum CodingKeys: String, CodingKey {
    case formType
    case code
    case equitySwapInvolved
  }
}

struct Amounts: Codable {
  let shares: Float?
  let pricePerShare: Float?
  let acquiredDisposedCode: String?
  
  enum CodingKeys: String, CodingKey {
    case shares
    case pricePerShare
    case acquiredDisposedCode
  }
}

struct PostTransactionAmounts: Codable {
  let sharesOwnedFollowingTransaction: Float?
  let valueOwnedFollowingTransaction: Float?
  
  enum CodingKeys: String, CodingKey {
    case sharesOwnedFollowingTransaction
    case valueOwnedFollowingTransaction
  }
}

struct OwnershipNature: Codable {
  let directOrIndirectOwnership: String?
  let natureOfOwnership: String?
  
  enum CodingKeys: String, CodingKey {
    case directOrIndirectOwnership
    case natureOfOwnership
  }
}

struct Holdings: Codable {
  let securityTitle: String?
  let coding: Coding?
  let postTransactionAmounts: PostTransactionAmounts?
  let ownershipNautre: OwnershipNature?
  
  enum CodingKeys: String, CodingKey {
    case securityTitle
    case coding
    case postTransactionAmounts
    case ownershipNautre
  }
}

struct Footnote: Identifiable, Codable {
  var id  = UUID()
  let text: String?
  
  enum CodingKeys: String, CodingKey {
    case text
  }
}
