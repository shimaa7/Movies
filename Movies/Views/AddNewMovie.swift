//
//  AddNewMovie.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/23/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import Foundation
import UIKit

func addNewMovie(viewController: UIViewController, view: UIView, index: String, completionHandler:  @escaping (_ result: Movie,_ image: UIImage) -> ()) -> (UIView,UIButton){
    
    // layout setup
    let containerView = UIView()
    containerView.isHidden = true
    view.addSubview(containerView)
    containerView.backgroundColor = .white
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    
    let titleLabel = UILabel()
    titleLabel.textColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    titleLabel.text = "Movie title:"
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(titleLabel)

    let titleText = UITextField()
    titleText.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0)
    titleText.placeholder = "Write title ..."
    containerView.addSubview(titleText)
    
    let overViewLabel = UILabel()
    overViewLabel.textColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    overViewLabel.text = "Movie overview:"
    overViewLabel.textAlignment = .left
    overViewLabel.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(overViewLabel)
    
    let overViewText = UITextView()
    overViewText.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0)
    overViewText.placeholder = "Write overview ..."
    containerView.addSubview(overViewText)
    
    let dateLabel = UILabel()
    dateLabel.textColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    dateLabel.text = "Movie date:"
    dateLabel.textAlignment = .left
    dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(dateLabel)
    
    let dateText = UITextField()
    dateText.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0)
    dateText.placeholder = "DD/MM/YYY"
    containerView.addSubview(dateText)
    
    let addPoster = UILabel()
    addPoster.textColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    addPoster.text = "Poster Image:"
    addPoster.textAlignment = .left
    addPoster.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(addPoster)

    let poster = UIButton()
    poster.setImage(#imageLiteral(resourceName: "movies_poster"), for: .normal)
    poster.backgroundColor = .white
    containerView.addSubview(poster)

    let addButton = UIButton()
    addButton.setTitle("ADD", for: .normal)
    addButton.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
    addButton.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(addButton)
    
    let cancelButton = UIButton()
    cancelButton.setTitle("CANCEL", for: .normal)
    cancelButton.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
    cancelButton.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    containerView.addSubview(cancelButton)
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        containerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6),
        containerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9)
        ])
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10),
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
        titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    titleText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        titleText.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
        titleText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        titleText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
        titleText.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    overViewLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        overViewLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
        overViewLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10),
        overViewLabel.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 5),
        overViewLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    overViewText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        overViewText.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
        overViewText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        overViewText.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 3),
        overViewText.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.15)
        ])
    
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        dateLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
        dateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10),
        dateLabel.topAnchor.constraint(equalTo: overViewText.bottomAnchor, constant: 5),
        dateLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    dateText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        dateText.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
        dateText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        dateText.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
        dateText.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    addPoster.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        addPoster.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
        addPoster.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        addPoster.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 5),
        addPoster.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08)
        ])
    
    poster.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        poster.leftAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 15),
        poster.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
        poster.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 15),
        poster.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.15)
        ])
    
    addButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        addButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
        addButton.rightAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -5),
        addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        addButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1)
        ])
    
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        cancelButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 5),
        cancelButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
        cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        cancelButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1)
        ])

    // actions
    UIView.transition(with: view, duration: 0.2, options: .beginFromCurrentState, animations: {
        containerView.isHidden = false
    })
    
    poster.addTargetClosure { (_) in
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        viewController.present(myPickerController, animated: true, completion: nil)
    }
    cancelButton.addTargetClosure { (_) in
        containerView.isHidden = true
    }
    addButton.addTargetClosure { (_) in
        let movie = Movie(title: titleText.text ?? "", overview: overViewText.text ?? "", poster: index, date: dateText.text ?? "")
        completionHandler(movie, poster.imageView?.image ?? #imageLiteral(resourceName: "movies_poster"))
        containerView.isHidden = true
        return
    }
    
    return (containerView, poster)
}

