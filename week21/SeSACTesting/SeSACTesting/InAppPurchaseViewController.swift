//
//  InAppPurchaseViewController.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/15/23.
//

import UIKit
import StoreKit

class InAppPurchaseViewController: UIViewController {
    
    //직접 작성한 영수증 검증 로직
    func verifyRecipt(transaction: SKPaymentTransaction, productID: String){
        let reciptFileURL = Bundle.main.appStoreReceiptURL
        let reciptData = try? Data(contentsOf: reciptFileURL!)
        let reciptString = reciptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print(reciptString)
        
    }
    //1 상품 정의
    var productIdentifiers: Set<String> = ["com.alexcho617.SeSACTesting.coin100"]
    
    var productArray = Array<SKProduct>()
    var product: SKProduct!
    
    @IBOutlet weak var ProductLabel: UILabel!
    
    
    @IBAction func BuyButton(_ sender: UIButton) {
        //5
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
    }
    
    //2 정의된 상품이 실제로 앱스토어 커넥트에 존재하는지 + 사용자의 디바이스가 결제 가능한지
    func requestProductData(){
        if SKPaymentQueue.canMakePayments(){
            print("인앱 결제 가능")
            //인앱 상품 조회
            let request = SKProductsRequest(productIdentifiers: productIdentifiers)
            request.delegate = self
            request.start()
        }else{
            print("인앱 결제 불가")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension InAppPurchaseViewController: SKProductsRequestDelegate{
    //4 상품 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        if products.count > 0 {
            for item in products{
                product = item //옵션
                productArray.append(item)
                print(item.productIdentifier)
                print(item.localizedTitle)
                print(item.price)
                print(item.priceLocale)
            }
        }
    }
}


//SKPaymentTransactionObserver: 구매 승인 취소에 대한 프로토콜
extension InAppPurchaseViewController: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print(#function)
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("Purchased")
                print(transaction.payment.productIdentifier) //영수증에 나와있는 productID확인
                //영수증 검증
                verifyRecipt(transaction: transaction, productID: transaction.payment.productIdentifier)
            case .failed:
                print("Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("restored")
            default:
                print("DEfault")
            
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print(#function)
        for transaction in transactions {
            print(transaction)
        }
    }
    
    
    
    
}
