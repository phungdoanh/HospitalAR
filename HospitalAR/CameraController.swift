//
//  CameraController.Swift
//  HospitalAR
//
//  Based on code from https://www.appcoda.com/barcode-reader-swift/
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet var popupView:UIView!
    @IBOutlet weak var foundTitle: UILabel!
    @IBOutlet weak var foundText: UILabel!
    @IBOutlet weak var clueContainer: UIView!
    @IBOutlet var clueLabel:UILabel!
    @IBOutlet weak var messageConstraint: NSLayoutConstraint!
    
    var wrongCodeView: UIView?
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var popupVisible = false
    
    var currentClue: Clue? // Comes in from preceeding scene
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up popup and move offscreen
        // Set up popup and move offscreen
        popupView.layer.shadowOpacity = 0.5
        popupView.layer.shadowOffset = CGSize(width: 0, height: 0)
        popupView.layer.shadowRadius = 3
        popupView.layer.shadowColor = UIColor.lightGray.cgColor
        messageConstraint.constant = -self.view.frame.size.height
        foundTitle.text = currentClue?.foundTitle
        foundText.text = currentClue?.foundText
        clueLabel.text = currentClue?.clueText
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        wrongCodeView = UIView()
        wrongCodeView?.backgroundColor = UIColor.red
        wrongCodeView?.layer.shadowOpacity = 0.5
        wrongCodeView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        wrongCodeView?.layer.shadowRadius = 3
        wrongCodeView?.layer.shadowColor = UIColor.lightGray.cgColor
        wrongCodeView?.frame = CGRect.zero
        
        let wrongCodeLabel = UILabel()
        wrongCodeLabel.text = " Close... but wrong code "
        wrongCodeLabel.textColor = UIColor.white
        wrongCodeLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrongCodeLabel.adjustsFontSizeToFitWidth = true;
        wrongCodeLabel.textAlignment = .center;
        
        wrongCodeView?.addSubview(wrongCodeLabel)
        
        view.addSubview(wrongCodeView!)
        view.bringSubview(toFront: wrongCodeView!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubview(toFront: clueContainer)
        view.bringSubview(toFront: popupView)
    }

    // Called when QR Code is Detected
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            wrongCodeView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if let codeUrl = metadataObj.stringValue {
            let regex = try! NSRegularExpression(pattern: "\\/clue\\/([0-9]+)")
            if let match = regex.matches(in: codeUrl, options: [], range: NSRange(location: 0, length: codeUrl.count)).first {
                let id = (codeUrl as NSString).substring(with: match.range(at:1))
                if Int(id) == currentClue!.id {
                    // Show the popup if it's not opened already
                    if(!popupVisible){
                        showPopup()
                    }
                } else {
                    // QR Code references a clue that doesn't exist
                    let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                    
                    let width = barCodeObject?.bounds.width
                    let height = width!/6
                    let newX = (barCodeObject?.bounds.midX)! - width!/2
                    let newY = (barCodeObject?.bounds.maxY)! + 10
                    print("Could not find Clue: \(newX), \(newY)")
                    wrongCodeView?.frame = CGRect(x: newX, y: newY, width: width!, height: height)
                }
            } else {
                // QR code is malformed (or doesn't have our URL)
            }
        } else {
            // QR code doesn't have text in it
        }
    }
    
    func showPopup() {
        popupVisible = true;
        clueContainer.isHidden = true
        messageConstraint.constant = 0;
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        (UIApplication.shared.delegate as! AppDelegate).getUserRealm { realm in
            try! realm.write {
                let completed = CompletedClue()
                completed.id = self.currentClue!.id
                realm.add(completed)
            }
        }
    }
    
    func hidePopup(){
        popupVisible = false;
        messageConstraint.constant = -self.view.frame.size.height;
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func statusTap(_ sender: Any) {
        // Open Clue popup in the simulator with a tap (since there's no camera)
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            showPopup()
        #endif
    }
    
    @IBAction func nextClueTap(_ sender: Any) {
        hidePopup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
