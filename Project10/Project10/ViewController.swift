//
//  ViewController.swift
//  Project10
//
//  Created by Dave Johnson on 8/16/20.
//  Copyright © 2020 Dave Johnson Studios. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
  var people: [Person] = []

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

    collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "Person")
  }

  @objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
      fatalError("Unable to dequeue PersonCell.")
    }

    let person = people[indexPath.item]
    let imagePath = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.name.text = person.name
    cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension ViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
      guard let newName = ac?.textFields?[0].text else {
        return
      }

      person.name = newName
      self?.collectionView.reloadData()
    })

    present(ac, animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 140, height: 180)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else {
      return
    }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }

    let person = Person(name: "Unknown", image: imageName)
    people.append(person)
    collectionView.reloadData()

    dismiss(animated: true)
  }

  fileprivate func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
  }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
