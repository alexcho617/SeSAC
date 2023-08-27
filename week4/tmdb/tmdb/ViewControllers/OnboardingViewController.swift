//
//  OnboardingViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit
import SnapKit
class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
 
    

    var list: [UIViewController] = [First(), Second()]
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        view.backgroundColor = .gray
        
        guard let first = list.first else {return}
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        let nextIndex = currentIndex + 1
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
    //page control
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else {return 0} //그냥 0을 리턴하는거랑 어떤 차이일까?
        return index
    }
    



}

class First: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class Second: UIViewController{
    let button = {
        let view = UIButton()
        view.setTitle("START", for: .normal)
        view.tintColor = .blue
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        print("button pressed")
        UserDefaults.standard.set(true, forKey: "isLaunchedBefore")
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let trendVC = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as? TrendViewController
        sceneDelegate?.window?.rootViewController = trendVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
