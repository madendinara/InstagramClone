//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    // MARK: - Intermal properties
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(user: user)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        checkIfUserLoggedIn()
        self.delegate = self
    }
    
    // MARK: - Methods
    
    func configureViewControllers(user: User) {
        view.backgroundColor = .white

        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "home_unselected"), selectedImage: UIImage(imageLiteralResourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        let search = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "search_unselected"), selectedImage: UIImage(imageLiteralResourceName: "search_selected"), rootViewController: SearchController())
        let imageSelect = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "plus_unselected"), selectedImage: UIImage(imageLiteralResourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        let notification = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "like_unselected"), selectedImage: UIImage(imageLiteralResourceName: "like_selected"), rootViewController: NotificationController())
        
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "profile_unselected"), selectedImage: UIImage(imageLiteralResourceName: "profile_selected"), rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelect, notification, profile]
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
    }
    
    
    func fetchUser(){
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func didFinishPickingImage(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: true) {
                guard let pickedImage = items.singlePhoto?.image else { return }
                let controller = UploadPostController(postImage: pickedImage)
                let navController = UINavigationController(rootViewController: controller)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: false, completion: nil)
                
            }
        }
    }

}

extension MainTabController: LoginControllerDelegate {
    func authDidComplete() {
        self.dismiss(animated: true, completion: nil)
        fetchUser()
    }
    
}

// MARK: - UITabBarControllerDelegate
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesBottomBar = false
            config.hidesStatusBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingImage(picker)
            
        }
        return true
    }
}
