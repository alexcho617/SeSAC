//
//  OnboardingViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/25.
//

import UIKit


class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
    
    var list: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        view.backgroundColor = .gray
        
        guard let first = list.first else {return}
        //주요 함수
        setViewControllers([first], direction: .forward, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //first vc
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let afterIndex = currentIndex + 1
        return afterIndex >= list.count ? nil : list[afterIndex] // >= 안하면 index error, index와 count는 1 차이가 나기 때문에 = 를 해야함
    }
    
    
    //page control은 style이 scroll, horizontal 일때만 가능
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        //guard let에 2개 구문
        //viewControllers? 이거는 pageviewcontroller 내에 들어있는 변수
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else {return 0}
        
        return index
    }
}




class FirstViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class SecondViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class ThirdViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
