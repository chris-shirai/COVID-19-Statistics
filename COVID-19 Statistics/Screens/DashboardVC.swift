//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let itemViewThree = UIView()

    var itemViews: [UIView] = []
    var selectedCountry: SingleCountryIdentityData!
    var covidData: CountryCovidData!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()

        layoutUI()
        getCountryCovidData()

    }

    func getCountryCovidData() {
        NetworkManager.shared.getCountryCovidData(for: selectedCountry.api_name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let countryCovidData):
                DispatchQueue.main.async {

                    self.covidData = countryCovidData

                    if(!countryCovidData.response.isEmpty){
                        
                        let a = countryCovidData.response[0]
                        

                        self.add(childVC: C19CountryInfoHeaderVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.headerView)

                        self.addStackView(itemView: self.itemViewOne, itemInfoTypeOne: .newCases, countOne: a.cases.new!, itemInfoTypeTwo: .activeCases, countTwo: String(a.cases.active))

                        self.addStackView(itemView: self.itemViewTwo, itemInfoTypeOne: .newDeaths, countOne: a.deaths.new!, itemInfoTypeTwo: .totalDeaths, countTwo: String(a.deaths.total))


                        self.addStackView(itemView: self.itemViewThree, itemInfoTypeOne: .recoveredCases, countOne: String(a.cases.recovered), itemInfoTypeTwo: .totalCases, countTwo: String(a.cases.total))
                    }

                    


                }

            case .failure(let error): break // add error message
            }
        }
    }


    private func addStackView(itemView: UIView, itemInfoTypeOne: ItemInfoType, countOne: String, itemInfoTypeTwo: ItemInfoType, countTwo: String) {
        let itemInfoViewOne = C19ItemInfoView()
        let itemInfoViewTwo = C19ItemInfoView()

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20
        itemView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 90)
            ])


        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

        itemInfoViewOne.set(itemInfoType: itemInfoTypeOne, withCount: countOne)
        itemInfoViewTwo.set(itemInfoType: itemInfoTypeTwo, withCount: countTwo)
    }


    func setCountryValue(val: SingleCountryIdentityData) {
        selectedCountry = val
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))

        navigationItem.rightBarButtonItem = doneButton
    }

    func layoutUI() {

        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView, itemViewOne, itemViewTwo, itemViewThree]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
                ])
        }

//        itemViewOne.backgroundColor = .systemPink
//        itemViewTwo.backgroundColor = .systemBlue
//        itemViewThree.backgroundColor = .systemYellow

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewThree.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            itemViewThree.heightAnchor.constraint(equalToConstant: itemHeight)
            ])
    }

    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }


    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
