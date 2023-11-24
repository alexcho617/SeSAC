//
//  ViewController.swift
//  RxSwiftWithSingle
//
//  Created by jack on 2023/11/24.
//

import UIKit

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    let addJokeButton: UIButton = {
       let button = UIButton()
        button.setTitle("농담 추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 22
        button.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        return button
    }()
    
    let jokeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    var jokes: [Joke] = []
    lazy var jokesSubject = BehaviorSubject<[Joke]>(value: jokes)
    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.register(JokeTableViewCell.self, forCellReuseIdentifier: JokeTableViewCell.identifier)
        return tv
    }()
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(jokeCountLabel)
        jokeCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(jokeCountLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(addJokeButton)
        addJokeButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        bindRx()
        
    }
    
    func bindRx() {
        addJokeButton
            .rx
            .tap
            .observe(on: MainScheduler.instance)

            .flatMap {
                Network.fetchJoke() //Single<Joke>
//                Network.fetchJoke() //Observable<Joke>

//            .asSingle() // 두번째 클릭때부터 버튼 자체가 dispose 되어버림. 버튼 스트림을 싱글로 변환하여 한번 이벤트 방출 후 구독 종료시켰음
        //에러처리 1번 캐치
//            .catch{ error in
//                return Observable.just(Joke(error: true, category: "", type: "", joke: "", id: 0, safe: false, lang: "")) //더미 데이터
//            }
            .debug() //Observable<Observable<Joke>>
            .subscribe(with: self) { owner, joke in
                owner.jokes.append(joke)
                owner.jokesSubject.onNext(owner.jokes)
            }
            .disposed(by: bag)
        
        jokesSubject
            .bind(to: tableView.rx.items(cellIdentifier: JokeTableViewCell.identifier, cellType: JokeTableViewCell.self)) { index, item, cell in
                cell.jokeLabel.text = item.joke
            }
            .disposed(by: bag)
        
        jokesSubject
            .subscribe(with: self) { owner, jokes in
                owner.jokeCountLabel.text = "\(jokes.count)개"
            }
            .disposed(by: bag)
    }

}
