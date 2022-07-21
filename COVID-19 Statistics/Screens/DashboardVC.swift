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
    
    let dateLabel = C19BodyLabel(textAlignment: .center)

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
                        
                        let data = countryCovidData.response[0]

                        self.add(childVC: C19CountryInfoHeaderVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.headerView)

                        self.addStackView(itemView: self.itemViewOne,
                                          itemInfoTypeOne: .newCases,
                                          countOne: data.cases.new != nil ? UIHelper.formatPosNegNumber(countString: data.cases.new!) : "0",
                                          itemInfoTypeTwo: .activeCases,
                                          countTwo: data.cases.active != nil ? UIHelper.formatNumber(int: data.cases.active!) : "n/a")

                        self.addStackView(itemView: self.itemViewTwo,
                                          itemInfoTypeOne: .newDeaths,
                                          countOne: data.deaths.new != nil ? UIHelper.formatPosNegNumber(countString: data.deaths.new!) : "0",
                                          itemInfoTypeTwo: .totalDeaths,
                                          countTwo: UIHelper.formatNumber(int: data.deaths.total))

                        self.addStackView(itemView: self.itemViewThree,
                                          itemInfoTypeOne: .recoveredCases,
                                          countOne: data.cases.recovered != nil ? UIHelper.formatNumber(int: data.cases.recovered!) : "n/a",
                                          itemInfoTypeTwo: .totalCases,
                                          countTwo: UIHelper.formatNumber(int: data.cases.total))
                        
                        
                        self.dateLabel.text = "Last updated \(self.getCurrentDateTime(dateTime: data.time))"
                    }

                }

            case .failure(let error): break // add error message
            }
        }
    }
    
    
    // Functionality from https://stackoverflow.com/questions/41907419/ios-swift-3-convert-yyyy-mm-ddthhmmssz-format-string-to-date-object
    private func getCurrentDateTime(dateTime: String) -> String{

        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateTime)!
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        
        return dateString
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

        itemViews = [headerView, itemViewOne, itemViewTwo, itemViewThree, dateLabel]

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
            itemViewThree.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewThree.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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
