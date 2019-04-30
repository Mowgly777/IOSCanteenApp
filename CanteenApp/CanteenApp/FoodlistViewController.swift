//
//  FoodlistViewController.swift
//  CanteenApp
//
//  Created by Alex Coetzee on 2019/04/26.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class DayView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    var dayLabel: String?
    init(label: String) {
        super.init(frame: .zero)
        self.dayLabel = label
        initSubviews()
    }
    
    
    func initSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let foodPickerView: UIPickerView = {
            let pickerView = UIPickerView()
            
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
        addSubview(foodPickerView)
        
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        print("selected \(row)")
        
    }
    
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
            
            labelView.text = "Hamburger"
            labelView.translatesAutoresizingMaskIntoConstraints = false
            
            return labelView
        }()
        
        let foodDescriptionLabel: UILabel = {
            let labelView = UILabel()
            
            labelView.text = "It's a burger."
            labelView.font = labelView.font.withSize(12)
            labelView.translatesAutoresizingMaskIntoConstraints = false
            
            return labelView
        }()
        
        let foodImage: UIImageView = {
            let imageView = UIImageView()
            let image = UIImage(named: "hamburger")
            
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
            //view.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)
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
            //imgLogoContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
            imgLogoContainer.heightAnchor.constraint(equalToConstant: 100),
            //imgLogoContainer.bottomAnchor.constraint(equalTo: scrollView.topAnchor),
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
        
        let mondayView: DayView = DayView(label: "Monday")
        let tuesdayView: DayView = DayView(label: "Tuesday")
        let wednesdayView: DayView = DayView(label: "Wednesday")
        let thursdayView: DayView = DayView(label: "Thursday")
        let fridayView: DayView = DayView(label: "Friday")
        
        mondayView.translatesAutoresizingMaskIntoConstraints = false
        tuesdayView.translatesAutoresizingMaskIntoConstraints = false
        wednesdayView.translatesAutoresizingMaskIntoConstraints = false
        thursdayView.translatesAutoresizingMaskIntoConstraints = false
        fridayView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(mondayView)
        stackView.addArrangedSubview(tuesdayView)
        stackView.addArrangedSubview(wednesdayView)
        stackView.addArrangedSubview(thursdayView)
        stackView.addArrangedSubview(fridayView)
        
        stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        mondayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tuesdayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        wednesdayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        thursdayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        fridayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let orderButton = UIButton()
        orderButton.backgroundColor = .red
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.layer.cornerRadius = 15
        orderButton.setTitle("Order", for: .normal)
        scrollView.addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            //orderButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 40),
            orderButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
