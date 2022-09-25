//
//  PickerView.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import UIKit

class PickerView: UIView {

    // MARK: - Properties
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerContentView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var tapPickerView: UIDatePicker!

    @IBOutlet weak var heightPickerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBarConstraint: NSLayoutConstraint!

    typealias CompletionBlock = (() -> Void)

    enum PickerType {
        case date
        case time
    }

    private var cancelButtonTapped: CompletionBlock?
    private var doneButtonTapped: CompletionBlock?
    private var minimumDate: Date?
    private var maximumDate: Date?

    var isPickerVisible: Bool {
        return cancelButtonTapped != nil
    }

    private var pickerHeight: CGFloat {
        return isPickerVisible ? 235 : 0
    }

    // MARK: - Viewlifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }

    // MARK: - Private Methods
    private func initialSetup() {
        _ = Bundle.main.loadNibNamed(nameOfClass, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        contentView.clipsToBounds = true
        tapPickerView.setValue(UIColor.white, forKeyPath: "textColor")
            tapPickerView.preferredDatePickerStyle = .wheels
        tapPickerView.setValue(false, forKeyPath: "highlightsToday")
    }

    private func setPickerType(_ type: PickerType) {
        switch type {
        case .date:
            tapPickerView.datePickerMode = UIDatePicker.Mode.date
            tapPickerView.maximumDate = maximumDate
            tapPickerView.minimumDate = minimumDate
        case .time:
            tapPickerView.datePickerMode = UIDatePicker.Mode.time
            tapPickerView.minimumDate = minimumDate
        }
    }

    private func updatePickerHeight() {
        let headerHeight = UIEdgeInsets.safeAreaBottom + pickerHeight
        DispatchQueue.main.async {
            self.heightPickerViewConstraint.constant = self.pickerHeight
            self.heightBottomBarConstraint.constant = UIEdgeInsets.safeAreaBottom
            self.setPickerHeight(headerHeight)
        }
    }

    private func setPickerHeight(_ height: CGFloat) {
        if let heightConstraint = constraints.filter({ $0.firstAttribute == .height }).last {
            heightConstraint.constant = height
        }
    }

    // MARK: - Public Methods
    func setupPickerView(title: String, pickerType: PickerType = .date, minimumdate: Date? = nil, maximumdate: Date? = nil, cancel: CompletionBlock? = nil, done: CompletionBlock? = nil) {
        cancelButtonTapped = cancel
        doneButtonTapped = done
        self.labelTitle.text = title
        minimumDate = minimumdate
        maximumDate = maximumdate == nil ? Date() : maximumdate
        updatePickerHeight()
        setPickerType(pickerType)
    }

    // MARK: - UIButton Methods
    @IBAction func actionOnCancel(_ sender: UIButton) {
        self.cancelButtonTapped?()
    }

    @IBAction func actionOnDone(_ sender: UIButton) {
        self.doneButtonTapped?()
    }
}
