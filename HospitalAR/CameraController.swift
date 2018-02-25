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
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var popupVisible = false
    
    var currentClue: Clue? // Comes in from preceeding scene
    var foundClue: Clue?
    
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
        
        // Start video capture.
        captureSession.startRunning()
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 3
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
        
        // Move the message label and top bar to the front
        view.bringSubview(toFront: clueContainer)
        view.bringSubview(toFront: popupView)
    }

    // Called when QR Code is Detected
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if let codeUrl = metadataObj.stringValue {
            let regex = try! NSRegularExpression(pattern: "\\/clue\\/([0-9]+)")
            if let match = regex.matches(in: codeUrl, options: [], range: NSRange(location: 0, length: codeUrl.count)).first {
                let id = (codeUrl as NSString).substring(with: match.range(at:1))
                if Int(id) == currentClue!.id {
                    // Show barcode frame
                    let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                    qrCodeFrameView?.frame = barCodeObject!.bounds

                    // Show the popup if it's not opened already
                    if(!popupVisible){
                        showPopup()
                    }
                } else {
                    // QR Code references a clue that doesn't exist
                    print("Could not find Clue")
                }
            } else {
                // QR code is malformed (or doesn't have our URL)
            }
        } else {
            // QR code doesn't have text in it
        }
    }
    
    func showPopup() {
        foundClue = currentClue;
        popupVisible = true;
        print("Popping up!")
        clueContainer.isHidden = true
        messageConstraint.constant = 0;
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToClueController" {
            if let destination = segue.destination as? ClueController {
                if let clue = foundClue {
                    destination.completedClues.append(clue.id)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
