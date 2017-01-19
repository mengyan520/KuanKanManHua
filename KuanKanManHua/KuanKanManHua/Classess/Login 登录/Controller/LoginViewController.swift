//
//  LoginViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/27.
//  Copyright © 2016年 mm. All rights reserved.
//https://api.kkmh.com/v1/phone/signin
//https://api.kkmh.com/v1/users/me?user_id=4693850
//https://api.kkmh.com/v1/device/push_info
import UIKit
import SVProgressHUD

class LoginViewController: BaseViewController,BackViewDel {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    private func setUI()  {
        view.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_nav_close_normal_16x16_"), style: .plain, target: self, action:#selector(self.clickLeftButton(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "忘记密码", style: .plain, target: self, action: #selector(self.clickRightButton(sender:)))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:BLACK_COLOR,NSFontAttributeName:Font(fontSize: 14)], for: .normal)
        view.addSubview(backView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = UIImage.init().ImageWithColor(color: CLEAR_COLOR)
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.init()
        topView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 懒加载
    fileprivate lazy var backView:BackView = {
        let view = BackView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64))
        view.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0)
        view.del = self
        return view
    }()
    // MARK: - 登录请求
    func login()  {
        
        if NSString.init(string: backView.codeTextField.text!).length < 8 {
            
            SVProgressHUD.showError(withStatus: "密码长度至少8位")
            return
        }
       
        let parameters = [
            "password":  backView.codeTextField.text!,
            "phone": backView.phoneTextField.text!
        ]
        NetworkTools.shardTools.requestL(method: .post, URLString: "https://api.kkmh.com/v1/phone/signin", parameters: parameters) { (response, error) in
           // print(response)
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                if model.code != 200 {
                
                SVProgressHUD.showError(withStatus: model.message)
                return
                }
                MMUtils.setObject(data: model.data?.avatar_url, key: "avatar_url")
                MMUtils.setObject(data: model.data?.nickname, key: "nickname")
                MMUtils.setObject(data: model.data?.id, key: "uid")
                POSTNOTIFICATION(name: "UserLogin", data: nil)
                SVProgressHUD.showSuccess(withStatus: "登录成功")
                
                let delay = DispatchTime.now() + DispatchTimeInterval.seconds(1)
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    
                    self.clickLeftButton(sender: nil)
                }
            }
            
            
        }
        
    }
    // MARK: - 代理
    func didClickBtn(sender: UIButton) {
        switch sender.tag {
        case 1:
            if NSString.init(string: backView.phoneTextField.text!).length > 0 &&  NSString.init(string: backView.codeTextField.text!).length > 0 {
                
                login()
            }
            break
        default: break
            
        }
    }
    // MARK: - 事件
    func clickLeftButton(sender:UIBarButtonItem?) {
        dismiss(animated: true, completion: nil)
    }
    func clickRightButton(sender:UIBarButtonItem) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backView.phoneBtn.isHighlighted = false
        backView.codeBtn.isHighlighted = false
        view.endEditing(false)
    }
}
protocol BackViewDel:NSObjectProtocol {
    
    func didClickBtn(sender:UIButton)
    
}

fileprivate class BackView:UIView,UITextFieldDelegate {
    var phone = false
    var code = false
    weak var del:BackViewDel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    private func setUI() {
        addSubview(iconView)
        addSubview(editView)
        editView.addSubview(centerLine)
        editView.addSubview(phoneBtn)
        editView.addSubview(codeBtn)
        
        editView.addSubview(phoneTextField)
        editView.addSubview(codeTextField)
        addSubview(loginBtn)
        addSubview(registerBtn)
        addSubview(bottomLine)
        addSubview(qqBtn)
        addSubview(weixinBtn)
        bottomLine.addSubview(centerlbl)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.centerX.equalTo(self.snp.centerX)
        }
        editView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(80)
            make.width.equalTo(iconView.snp.width).offset(40)
        }
        centerLine.snp.makeConstraints { (make) in
            
            make.centerX.centerY.equalTo(editView)
            make.height.equalTo(1)
            make.width.equalTo(editView.snp.width)
        }
        phoneBtn.snp.makeConstraints { (make) in
            make.top.equalTo(editView.snp.top).offset(10)
            make.left.equalTo(editView.snp.left).offset(20)
        }
        codeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(centerLine.snp.bottom).offset(10)
            make.left.equalTo(editView.snp.left).offset(20)
        }
        phoneTextField.snp.makeConstraints { (make) in
            
            make.top.equalTo(phoneBtn.snp.top)
            make.left.equalTo(editView.snp.left).offset(46)
            make.right.equalTo(editView.snp.right).offset(-10)
            make.height.equalTo(phoneBtn.snp.height)
        }
        codeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(codeBtn.snp.top)
            make.left.equalTo(codeBtn.snp.right).offset(5)
            make.right.equalTo(editView.snp.right).offset(-10)
            make.height.equalTo(codeBtn.snp.height)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(editView.snp.bottom).offset(10)
            make.left.right.equalTo(editView)
            
            make.height.equalTo(42)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(30)
            
            
            make.centerX.equalTo(loginBtn.snp.centerX)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(registerBtn.snp.bottom).offset(30)
            make.left.right.equalTo(editView)
            
            make.height.equalTo(1)
        }
        centerlbl.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(bottomLine)
        }
        qqBtn.snp.makeConstraints { (make) in
            make.top.equalTo(centerlbl.snp.bottom).offset(20)
            make.left.equalTo(editView.snp.left)
        }
        weixinBtn.snp.makeConstraints { (make) in
            make.top.equalTo(centerlbl.snp.bottom).offset(20)
            make.right.equalTo(editView.snp.right)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClick(sender:UIButton)  {
        del?.didClickBtn(sender: sender)
    }
    fileprivate func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            codeBtn.isHighlighted = false
            phoneBtn.isHighlighted = true
            iconView.image = UIImage.init(named: "ic_login_visible")
            
        }else {
            codeBtn.isHighlighted = true
            phoneBtn.isHighlighted = false
            iconView.image = UIImage.init(named: "ic_login_invisible")
            
        }
    }
    func textFieldDidChange(textField:UITextField)   {
        
    }
    fileprivate lazy var iconView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "ic_login_visible")
        return view
    }()
    fileprivate lazy var editView:UIView = {
        let view = UIView()
        view.backgroundColor = WHITE_COLOR
        view.layer.cornerRadius = 8
        return view
    }()
    fileprivate lazy var centerLine:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        
        return view
    }()
    fileprivate lazy var phoneBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_login_user_normal", backImageName: nil, highlightedImageName: "ic_login_user_highlighted", target: nil, actionName: nil)
        
        
        return btn
    }()
    fileprivate lazy var codeBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_login_password_normal", backImageName: nil, highlightedImageName: "ic_login_password_highlighted", target: nil, actionName: nil)
        
        
        return btn
    }()
    
    lazy var phoneTextField:UITextField = {
        let view = UITextField()
        view.keyboardType = .phonePad
        view.placeholder = "您的手机号"
        view.font = Font(fontSize: 15)
        view.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        view.delegate = self
        return view
    }()
    lazy var codeTextField:UITextField = {
        let view = UITextField()
        view.placeholder = "请输入密码"
        view.font = Font(fontSize: 15)
        view.keyboardType = .default
        view.isSecureTextEntry = true
        view.delegate = self
        view.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        return view
    }()
    fileprivate lazy var loginBtn:UIButton = {
        let btn = UIButton.init(title: "登录", color: WHITE_COLOR, fontSize: 15, target: self, actionName: #selector(self.btnClick(sender:)))
        btn.setBackgroundImage(UIImage(named: "ic_login_submit_bg_normal"), for: .normal)
        btn.tag = 1
        
        return btn
    }()
    fileprivate lazy var registerBtn:UIButton = {
        let btn = UIButton.init(title: "立即注册", color: WHITE_COLOR, fontSize: 15, target: self, actionName: nil)
        
        
        return btn
    }()
    fileprivate lazy var bottomLine:UIView = {
        let view = UIView()
        view.backgroundColor = RGB(r: 110, g: 110, b: 110, a: 1.0)
        
        return view
    }()
    fileprivate lazy var centerlbl:UILabel = {
        
        let lbl = UILabel.init(title: "      其他方式登录      ", fontSize: 14, color: RGB(r: 110, g: 110, b: 110, a: 1.0), screenInset: 10)
        lbl.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0)
        return lbl
    }()
    fileprivate lazy var qqBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_login_QQ", backImageName: nil, highlightedImageName: "ic_login_QQ_pressed", target: self, actionName: nil)
        
        
        return btn
    }()
    fileprivate lazy var weixinBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_login_weixin", backImageName: nil, highlightedImageName: "ic_login_weixin_pressed", target: self, actionName: nil)
        
        
        return btn
    }()
}
