//
//  TimerViewController.swift
//  BookToy
//
//  Created by Alex Cho on 2023/09/24.
//

import UIKit
import SnapKit
import RealmSwift

class TimerViewController: UIViewController {
    let vm = TimerViewModel()
    let timerLabel = {
        let view = UILabel()
        view.text = "00:00"
        view.tintColor = .label
        return view
    }()
    
    let mainButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.label, for: .normal)
        view.setTitle("Play", for: .normal)
        view.setImage(UIImage(systemName: "play"), for: .normal)
        return view
    }()
    
    let stopButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.label, for: .normal)
        view.setTitle("Stop", for: .normal)
        view.setImage(UIImage(systemName: "stop"), for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(timerLabel)
        view.addSubview(mainButton)
        view.addSubview(stopButton)
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonClicked), for: .touchUpInside)
        bindView()
    }
    
    private func bindView(){
        vm.isTimerOn.bind { [self] value in
            if value == true{
                mainButton.setTitle("Pause", for: .normal)
                mainButton.setImage(UIImage(systemName:"pause"), for: .normal)
            }else{
                mainButton.setTitle("Play", for: .normal)
                mainButton.setImage(UIImage(systemName:"play"), for: .normal)
            }
        }
    }
    @objc func mainButtonClicked(){
        vm.mainButtonClicked()
    }
    @objc func stopButtonClicked(){
        vm.stopButtonClicked()
        
    }
    func setConstraints(){
        timerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        mainButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-32)
        }
        
        stopButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(32)
        }
    }
}
