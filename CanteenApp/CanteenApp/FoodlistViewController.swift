//
//  FoodlistViewController.swift
//  CanteenApp
//
//  Created by Alex Coetzee on 2019/04/26.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class FoodItem {
    let foodName: String
    let foodDescription: String
    let foodImageString: String
    
    init(foodName: String, foodDescription: String, foodImageString: String) {
        self.foodName = foodName
        self.foodDescription = foodDescription
        self.foodImageString = foodImageString
    }
}

// This creates the data source
func create_food_list() -> [FoodItem] {
    var foodItem: [FoodItem] = []
    
    for i in (0..<5) {
        if (i == 4) {
            foodItem.append(FoodItem(foodName: "Nothing to order", foodDescription: "You're eating air!", foodImageString: "blocked"))
        } else {
            foodItem.append(FoodItem(foodName: "Hamburger", foodDescription: "It is a hamburger", foodImageString: "hamburger"))
        }
    }
    
    return foodItem
}

class DayView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.foodPickerView = UIPickerView()
        
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.foodPickerView = UIPickerView()
        initSubviews()
    }
    
    var dayLabel: String?
    init(label: String) {
        super.init(frame: .zero)
        self.foodPickerView = UIPickerView()
        self.dayLabel = label
        initSubviews()
    }
    
    var foodItems: [FoodItem]?
    init(label: String, foodItems: [FoodItem]) {
        super.init(frame: .zero)
        self.foodPickerView = UIPickerView()
        self.dayLabel = label
        self.foodItems = foodItems
        initSubviews()
    }
    
    var foodPickerView: UIPickerView?
    
    func initSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let innerFoodPickerView: UIPickerView = {
            var pickerView = UIPickerView()
            
            if (self.foodPickerView != nil) {
                pickerView = foodPickerView!
            }
            
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            
            return pickerView
        }()
        
        let dayLabel: UILabel = {
            let label = UILabel()
            
            if (self.dayLabel != nil) {
                label.text = self.dayLabel
            }
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        addSubview(dayLabel)
        addSubview(innerFoodPickerView)
        
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
//    {
          //use the row to get the selected row from the picker view
          //using the row extract the value from your datasource (array[row])
//        print("selected \(row)")
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return "Row \(row)"
    //    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Use datasource
        
        var givenView: UIView
        
        let foodLabel: UILabel = {
            let labelView = UILabel()
            
            labelView.text = foodItems?[row].foodName
            //labelView.text = "Hamburger"
            labelView.translatesAutoresizingMaskIntoConstraints = false
            
            return labelView
        }()
        
        let foodDescriptionLabel: UILabel = {
            let labelView = UILabel()
            
            //labelView.text = "It's a burger."
            labelView.text = foodItems?[row].foodDescription
            labelView.font = labelView.font.withSize(12)
            labelView.translatesAutoresizingMaskIntoConstraints = false
            
            return labelView
        }()
        
        let foodImage: UIImageView = {
            let imageView = UIImageView()
            //let image = UIImage(named: "hamburger")
            let image = UIImage(named: foodItems?[row].foodImageString ?? "hamburger")
            
            imageView.image = image
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        // UIView doesn't work because UIPicker
        if let v = view as? UILabel {
            givenView = v
        }
        else {
            givenView = UILabel()
        }
        
        givenView.addSubview(foodLabel)
        givenView.addSubview(foodDescriptionLabel)
        givenView.addSubview(foodImage)
        
        foodImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        foodImage.leftAnchor.constraint(equalTo: givenView.leftAnchor, constant: 10)
        foodImage.centerYAnchor.constraint(equalTo: givenView.centerYAnchor).isActive = true
        
        foodLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        foodLabel.centerYAnchor.constraint(equalTo: givenView.centerYAnchor, constant: -10).isActive = true
        
        foodDescriptionLabel.topAnchor.constraint(equalTo: foodLabel.bottomAnchor, constant: 5).isActive = true
        foodDescriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        
        return givenView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
}

class FoodlistViewController: UIViewController {
    var mondayView: DayView?
    var tuesdayView: DayView?
    var wednesdayView: DayView?
    var thursdayView: DayView?
    var fridayView: DayView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        mondayView = DayView(label: "Monday", foodItems: create_food_list())
        tuesdayView = DayView(label: "Tuesday", foodItems: create_food_list())
        wednesdayView = DayView(label: "Wednesday", foodItems: create_food_list())
        thursdayView = DayView(label: "Thursday", foodItems: create_food_list())
        fridayView = DayView(label: "Friday", foodItems: create_food_list())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.backgroundColor = .green
        
        let imgLogo:UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "Logo2")
            img.translatesAutoresizingMaskIntoConstraints = false
            img.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)
            
            return img
        }()
        
        let imgLogoContainer:UIView = {
            let container = UIView()
            container.backgroundColor = .red
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
        
        imgLogoContainer.addSubview(imgLogo)
        view.addSubview(imgLogoContainer)
        
        // img container constraints
        NSLayoutConstraint.activate([
            imgLogoContainer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imgLogoContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imgLogoContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            imgLogoContainer.heightAnchor.constraint(equalToConstant: 100),
            ])
        
        // img constraints
        NSLayoutConstraint.activate([
            imgLogo.centerXAnchor.constraint(equalTo: imgLogoContainer.centerXAnchor),
            imgLogo.topAnchor.constraint(equalTo: imgLogoContainer.topAnchor),
            imgLogo.heightAnchor.constraint(equalToConstant: 100),
            imgLogo.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        scrollView.delaysContentTouches = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: imgLogoContainer.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 50
        
        mondayView = DayView(label: "Monday", foodItems: create_food_list())
        tuesdayView = DayView(label: "Tuesday", foodItems: create_food_list())
        wednesdayView = DayView(label: "Wednesday", foodItems: create_food_list())
        thursdayView = DayView(label: "Thursday", foodItems: create_food_list())
        fridayView = DayView(label: "Friday", foodItems: create_food_list())
        
        mondayView?.translatesAutoresizingMaskIntoConstraints = false
        tuesdayView?.translatesAutoresizingMaskIntoConstraints = false
        wednesdayView?.translatesAutoresizingMaskIntoConstraints = false
        thursdayView?.translatesAutoresizingMaskIntoConstraints = false
        fridayView?.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mondayView!)
        stackView.addArrangedSubview(tuesdayView!)
        stackView.addArrangedSubview(wednesdayView!)
        stackView.addArrangedSubview(thursdayView!)
        stackView.addArrangedSubview(fridayView!)
        
        stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        mondayView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tuesdayView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        wednesdayView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        thursdayView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        fridayView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let orderButton = UIButton()
        orderButton.backgroundColor = .red
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.layer.cornerRadius = 15
        orderButton.setTitle("Order", for: .normal)
        orderButton.addTarget(self, action: #selector(orderFood), for: .touchUpInside)
        scrollView.addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 40),
            orderButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        
        //var selectedValue = pickerViewContent[pickerView.selectedRowInComponent(0)]
        
        //let selectedValue: String = (mondayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        
        //print("SELECTED: \(selectedValue)")
    }
    
    @objc func orderFood() {
        let mondayValue: String = (mondayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        let tuesdayValue: String = (tuesdayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        let wednesdayValue: String = (wednesdayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        let thursdayValue: String = (thursdayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        let fridayValue: String = (fridayView?.foodPickerView?.selectedRow(inComponent: 0).description)!
        
        print("Food Items Selected:\n Monday: \(mondayValue)\n Tuesday: \(tuesdayValue)\n Wednesday: \(wednesdayValue)\n Thursday: \(thursdayValue)\n Friday: \(fridayValue)")
    }
}
