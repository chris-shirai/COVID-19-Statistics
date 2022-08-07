//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

// The DashboardVC is displayed as a modal with information and population/covid statistics about a specific country
class DashboardVC: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let itemViewThree = UIView()

    let dateLabel = C19SecondaryTitleLabel(textAlignment: .center, fontSize: 24)
    let apiCreditLabel = C19BodyLabel(textAlignment: .center)
    let disclaimerLabel = C19BodyLabel(textAlignment: .center)

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

                    if(!countryCovidData.response.isEmpty) {

                        let data = countryCovidData.response[0]

                        self.add(childVC: C19CountryInfoHeaderVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.headerView)

                        self.addStackView(itemView: self.itemViewOne,
                            itemInfoTypeOne: .newCases,
                            countOne: data.cases.new != nil ? UIHelper.formatPosNegNumber(countString: data.cases.new!) : "--",
                            itemInfoTypeTwo: .activeCases,
                            countTwo: data.cases.active != nil ? UIHelper.formatNumber(int: data.cases.active!) : "--")

                        self.addStackView(itemView: self.itemViewTwo,
                            itemInfoTypeOne: .newDeaths,
                            countOne: data.deaths.new != nil ? UIHelper.formatPosNegNumber(countString: data.deaths.new!) : "--",
                            itemInfoTypeTwo: .totalDeaths,
                            countTwo: UIHelper.formatNumber(int: data.deaths.total))

                        self.addStackView(itemView: self.itemViewThree,
                            itemInfoTypeOne: .recoveredCases,
                            countOne: data.cases.recovered != nil ? UIHelper.formatNumber(int: data.cases.recovered!) : "--",
                            itemInfoTypeTwo: .totalCases,
                            countTwo: UIHelper.formatNumber(int: data.cases.total))


                        self.dateLabel.text = "Last updated \(self.getCurrentDateTime(dateTime: data.time))"
                        self.apiCreditLabel.text = "COVID-19 data from RapidAPI / Api-Sports"
                        self.disclaimerLabel.text = "Some data may be unreported."
                    }

                }

            case .failure(let error): break // add error message
            }
        }
    }


    // Functionality from https://stackoverflow.com/questions/41907419/ios-swift-3-convert-yyyy-mm-ddthhmmssz-format-string-to-date-object
    private func getCurrentDateTime(dateTime: String) -> String {

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
        let itemInfoViewLeft = C19ItemInfoView(itemView: itemView)
        let itemInfoViewRight = C19ItemInfoView(itemView: itemView)

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20
        itemView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
            ])


        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        stackView.addArrangedSubview(itemInfoViewLeft)
        stackView.addArrangedSubview(itemInfoViewRight)

        itemInfoViewLeft.set(itemInfoType: itemInfoTypeOne, withCount: countOne)
        itemInfoViewRight.set(itemInfoType: itemInfoTypeTwo, withCount: countTwo)
    }


    func setCountryValue(val: SingleCountryIdentityData) {
        selectedCountry = val
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        
        PersistenceManager.updateWith(favorite: self.selectedCountry, actionType: .add) { [weak self] error in
            
            guard let self = self else {return}
            
            guard let error = error else {
                
                
                self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favorited this country", buttonTitle: "Ok")
                // success
                return
            }
            
            // something went wrong
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")

        }
         
    }

    func layoutUI() {

        let padding: CGFloat = 20
        let secondaryPadding: CGFloat = 2
        let headerHeight: CGFloat = 100
        let itemHeight: CGFloat = UIHelper.calculateCovidInfoCardHeight(in: view, headerHeight: headerHeight)

        itemViews = [headerView, itemViewOne, itemViewTwo, itemViewThree, dateLabel, apiCreditLabel, disclaimerLabel]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
                ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: secondaryPadding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewThree.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: secondaryPadding),
            itemViewThree.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewThree.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),

            apiCreditLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            apiCreditLabel.heightAnchor.constraint(equalToConstant: 18),
            
            disclaimerLabel.topAnchor.constraint(equalTo: apiCreditLabel.bottomAnchor, constant: 5),
            disclaimerLabel.heightAnchor.constraint(equalToConstant: 18)
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
