//
//  InAppPurchaseViewController.swift
//  SeSACTesting
//
//  Created by Alex Cho on 12/15/23.
//

import UIKit
import StoreKit
/*
 1. 유료 계약 활성화 / 개발자 계정 / 앱스토어 커넥트 Capabilities
 2. Appstore ocnnect in app product registration
 3. in app purchase: check if payment possible + look up product -> SKProductRequest
 4. SKProductRequestDelegate: Look up product information
 5. SKPaymentTransactionObserver check payment status -> exception, error
 6. Logic done -> Check recipt, manage in app purchases in userdefaults
 7. Recipt check: if server exists, server can do it. if no server, client can (but prone to 탈취)
 */

class InAppPurchaseViewController: UIViewController {
    
    //직접 작성한 영수증 검증 로직
    func verifyRecipt(transaction: SKPaymentTransaction, productID: String){
        let reciptFileURL = Bundle.main.appStoreReceiptURL
        let reciptData = try? Data(contentsOf: reciptFileURL!)
        let reciptString = reciptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print(reciptString ?? "no recipt")
        
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
