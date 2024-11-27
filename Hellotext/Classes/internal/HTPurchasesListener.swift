//
//  HTPurchasesListener.swift
//  Pods
//
//  Created by Breno Morais on 27/11/24.
//


import StoreKit

enum HTPurchasesStatus {
    case purchased
    case failed
    case restored
}

protocol HTPurchasesManagerDelegate {
    func updateTransaction(state: SKPaymentTransactionState)
}

class HTPurchasesManager: NSObject, SKPaymentTransactionObserver {
    let delegate: HTPurchasesManagerDelegate

    init(delegate: HTPurchasesManagerDelegate) {
        self.delegate = delegate
        super.init()
        SKPaymentQueue.default().add(self)
    }

    // Método para observar as transações
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            HTDebug.htPrint("Status \(transaction.transactionState.rawValue): \(transaction.payment.productIdentifier)")
            self.delegate.updateTransaction(state: transaction.transactionState)
            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }

//    private func handlePurchase(_ transaction: SKPaymentTransaction) {
//        HTDebug.htPrint("Status \(transaction.transactionState.rawValue): \(transaction.payment.productIdentifier)")
//        self.delegate.updateTransaction(state: transaction.transactionState)
//        SKPaymentQueue.default().finishTransaction(transaction)
//    }
//
//    private func handleFailure(_ transaction: SKPaymentTransaction) {
//        HTDebug.htPrint("Compra falhou: \(transaction.error?.localizedDescription ?? "Erro desconhecido")")
//        self.delegate.updateTransaction(state: transaction.transactionState)
//        SKPaymentQueue.default().finishTransaction(transaction)
//    }
//
//    private func handleRestore(_ transaction: SKPaymentTransaction) {
//        HTDebug.htPrint("Compra restaurada: \(transaction.payment.productIdentifier)")
//        self.delegate.updateTransaction(state: transaction.transactionState)
//        SKPaymentQueue.default().finishTransaction(transaction)
//    }
}

