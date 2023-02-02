//
//  NoDataView.swift
//  LetsEat
//
//  Created by kamilcal on 27.12.2022.
//

import UIKit

class NoDataView: UIView {

    var view: UIView!
    
    
    @IBOutlet var decriptionLabel: UILabel!
    @IBOutlet var noDataTitleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
//    cihazda depolanan uygulama paketinden XIB dosyalarının yüklenmesini işler.
    required init? (coder: NSCoder){
        super.init(coder: coder)
        setupView()
    }
    
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "NoDataView", bundle: Bundle.main)
        let view = nib.instantiate(withOwner: self, options: nil) [0] as! UIView
        return view
    }
//    Bu yöntem, uygulama paketinden NoDataView XIB dosyasını bulur ve yükler ve içinde depolanan bir UIView örneği döndürür.
    
    func setupView(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func set(title: String, desc: String) {
        noDataTitleLabel.text = title
        decriptionLabel.text = desc
    }
}
