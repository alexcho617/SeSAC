//
//  TextViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class ContentViewController: BaseViewController {
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        view.text = "내용을 입력해주세요"
        return view
    }()
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let sampleView2 = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    var completionHandler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    deinit {
        print("deinit", self)
    }
    
    //going to make appear slowly
    func setAnimation(){
        //start
        sampleView.alpha = 0
        sampleView2.alpha = 0
        
        //end
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn]) { //repeat blocks completion
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .blue
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.sampleView2.alpha = 1
            }
            
        }


    }
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(150)
        }
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        sampleView2.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(sampleView).offset(100)
        }
    }
    
    override func configureView() {
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(sampleView2)

        setAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        completionHandler?(textView.text!)

    }
    //이걸 커스텀 클래스안에 넣어서 할 수 도 있음
    //UI related = main queue: gives click effect by reducing alpha and recovering it
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.sampleView2.alpha = 1
            UIView.animate(withDuration: 0.3){
                self.sampleView2.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.sampleView2.alpha = 0.5
            UIView.animate(withDuration: 0.3){
                self.sampleView2.alpha = 1
            }
        }
    }
    
}
