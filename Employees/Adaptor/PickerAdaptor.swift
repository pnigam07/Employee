////
////  PickerAdaptor.swift
////  Employees
////
////  Created by pankaj on 8/14/19.
////  Copyright © 2019 Nigam. All rights reserved.
////
//
//import UIKit
//
//class PickerAdaptor: NSObject {
//
//    let dataList:[String]?
//    var selectedValue: String?
//
//    init(dataList: [String] ) {
//        self.dataList = dataList
//    }
//
//}
//
//// MARK: UIPickerViewDelegate, UIPickerViewDataSource
//
//extension PickerAdaptor: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
////        if pickerView == cityPicker || pickerView == marritalStatusPicker {
////            return 1
////        }
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////        if pickerView == cityPicker {
////            return Constants.cityArray.count
////        }
////        if pickerView == marritalStatusPicker {
////            return Constants.marritialStatusArray.count
////        }
//        return dataList?.count ?? 0
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////        if pickerView == cityPicker {
////            return Constants.cityArray[row]
////        }
////        if pickerView == marritalStatusPicker {
////            return Constants.marritialStatusArray[row]
////        }
//        return dataList?[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == cityPicker {
//            cityTextField.text = Constants.cityArray[row]
//            return
//        }
//        if pickerView == marritalStatusPicker {
//            mariatalStatusTextField.text = Constants.marritialStatusArray[row]
//            return
//        }
//    }
//}
