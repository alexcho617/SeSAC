//
//  SearchViewController.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import UIKit
import SnapKit

//MARK: CollectionView + Diffable Data Source
class SearchViewController: UIViewController{
    let list = Array(0...100)
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureDataSource()
    }
    
    func configureHierarchy(){
        view.addSubview(collectionView)
    }

    func configureLayout(){
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //collectionviewflowlayout -> compositional layout
    func layout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func configureDataSource(){
        let cellRegi = UICollectionView.CellRegistration<SearchCell, Int> { cell, indexPath, itemIdentifier in
            cell.label.text = "\(itemIdentifier)"
            cell.imageView.image = UIImage(systemName: "star")
            cell.backgroundColor = .darkGray
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegi, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([1])
        snapshot.appendItems(list,toSection: 1)
        dataSource.apply(snapshot)
    }
}



//MARK: ScrollView + UIView
//class SearchViewController: UIViewController{
//    let scrollView = UIScrollView()
//    let contentView = UIView() //Separate class recommended
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        scrollView.delegate = self
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//
//    }
//
//    func configureContentView(){
//        contentView.addSubview(imageView)
//        contentView.addSubview(label)
//        contentView.addSubview(button)
//
//        imageView.backgroundColor = .orange
//        label.backgroundColor = .systemTeal
//        label.numberOfLines = 0
//        label.text = "liawjdlnasdasdasdasdasnasdasdasdasdasliawjdlnasdasdasdasdasnasdasdasdasdasliawjdlnasdasdasdasdasnasdasdasdasdasliawjdlnasdasdasdasdasnasdasdasdasdasliawjdlnasdasdasdasdasnasdasdasdasdas\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdasdawdwdawdasdawdasdasdliawjdl\nasdasdasdasdas\n\nasdawdas"
//        button.backgroundColor = .green
//
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)//bottom padding 50
//            make.bottom.equalTo(button.snp.top).offset(-50) //top padding, 50
//        }
//    }
//
//    func configureHierarchy(){
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//    }
//    func configureLayout(){
////        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        contentView.backgroundColor = .darkGray
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            make.width.equalTo(scrollView)
//        }
//
//
//    }
//
//}
//extension SearchViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
////        navigationController?.navigationBar.alpha = ...
//    }
//}
//MARK: StackView
//class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureHierarchy()
//        configureLayout()
//
//    }
//    func configureHierarchy(){
//        view.backgroundColor = .systemBackground
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//        configureStackView()
//
//    }
//
//    func configureLayout(){
//        scrollView.backgroundColor = .lightGray
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.spacing = 16
//        stackView.backgroundColor = .systemGreen
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(70)
//        }
//    }
    //가로 스택뷰인걸 어떻게 알았지? 기본이 가로인가?
//    func configureStackView(){
//        let labelOne = UILabel()
//        labelOne.text = "11111111111"
//        labelOne.textColor = .white
//        stackView.addArrangedSubview(labelOne)
//
//        let labelTwo = UILabel()
//        labelTwo.text = "222222222"
//        labelTwo.textColor = .white
//        stackView.addArrangedSubview(labelTwo)
//
//        let labelThree = UILabel()
//        labelThree.text = "333333333"
//        labelThree.textColor = .white
//        stackView.addArrangedSubview(labelThree)
//
//        let labelFour = UILabel()
//        labelFour.text = "444444444"
//        labelFour.textColor = .white
//        stackView.addArrangedSubview(labelFour)
//
//        let labelFive = UILabel()
//        labelFive.text = "5555555"
//        labelFive.textColor = .white
//        stackView.addArrangedSubview(labelFive)
//    }
//}
