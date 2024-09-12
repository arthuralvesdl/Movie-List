import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    private let contentView: SearchView
    
    init(contentView: SearchView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pesquisar"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.searchTextInput.delegate = self
        
        view.backgroundColor = UIColor.background
        view.addSubview(contentView)
        view.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //tap on done button
        textField.resignFirstResponder()
        return true
    }
}


