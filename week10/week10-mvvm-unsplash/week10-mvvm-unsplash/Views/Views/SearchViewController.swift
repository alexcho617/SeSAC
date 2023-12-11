//
//  SearchViewController.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

//MARK: CollectionView + Diffable Data Source
class SearchViewController: UIViewController, UISearchBarDelegate{
    let list = ["이모티콘이모티콘이모티콘이모티콘이모티콘이", "새싹새싹새싹새싹새싹새싹새싹새싹", "추석추석추석추석추석추석추석추석추석추석", "고래밥","컬렉션뷰레이아웃"]
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        configureDataSource()
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
            switch response {
            case .success(let photo):
                dump(photo)
                //data + UI snapshot
                let ratios = photo.results.map {
                    Ratio(ratio: $0.width/$0.height)
                }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 8, contentWidth: self.view.frame.width)
                
                //이 순서 중요
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.configureSnapshot(photo)
                
            case .failure(let failure):
                //alert or toast
                print(failure.localizedDescription)
            }
        }
    }
    
    fileprivate func configureSnapshot(_ item: Photo) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item.results)
        dataSource.apply(snapshot)
    }
    
//    //아이템 넓이 고정, 높이를 유동적으로
//    static func configurePinterestLayout() -> UICollectionViewLayout{
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        group.interItemSpacing = .fixed(10)
//
//        
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//    
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.scrollDirection = .vertical
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        layout.configuration = config
//        
//        return layout
//    }
    
    //MARK: compositional layout
    //크기는 3가지 종류로 잡을 수 있음: .fractional, .absolute, .estimated
    func configureTagLayout() -> UICollectionViewLayout{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .fractionalHeight(1.0)) //아이템: 넓이 = 그룹의 1/3, 높이 = 80 * 1.0 = 80
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //바구니
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .absolute(30)) // 그룹: 넓이 = 컬렉션뷰 사이즈 * 1.0, 높이 = 80
        //그룹 내에서 가로 설정된것
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3) //아이템이 1/3 크기면 3개를 넣으면 꽉 참 1/n * n = 1
        group.interItemSpacing = .fixed(8)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //수직 스크롤
        //layout config
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
    }

    
    func configureDataSource(){
        let cellRegi = UICollectionView.CellRegistration<SearchCell, PhotoResult> { cell, indexPath, itemIdentifier in
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb))
            cell.label.text = itemIdentifier.created_at
            cell.backgroundColor = .darkGray
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegi, for: indexPath, item: itemIdentifier)
        })
        
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
