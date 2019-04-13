import UIKit
import CoreMotion


class ViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    // Those three UILabels for displaying data of three coordinates of accelerometer
    
    // Button for starting and stooping activity accordinglyu to boolean value of button
    @IBOutlet weak var click: UIButton!
    var start:Bool = true
    
    var xvalue: String?
    var yvalue: String?
    var zvalue: String?
    
    // I dont know the data so set 0.5 above as a shaking please trace set it accordingingly to your accelemerator dat ain ios device shaking
    let xthreshold = 0.5
    let ythreshold = 0.5
    let zthreshold = 0.5
    
    
    // With the button Clicked it will check boolean value and perform accordingly
    @IBAction func retreiveData(_sender: UIButton){
        
        if (start == true){
            
            self.start = false
            click.setTitle(nil,for: .normal)
            click.setTitleColor(UIColor.white, for: .normal)
            click.setTitle("Stop",for: .normal)
            
            // tracing the data with the shaking
            motionManager.startAccelerometerUpdates(to: .main, withHandler: updateData)
            
        }else{
            
            self.start = false
            click.setTitle(nil,for: .normal)
            click.setTitleColor(UIColor.white, for: .normal)
            click.setTitle("Start",for: .normal)
            
            // stopping the activity
            motionManager.stopAccelerometerUpdates()
            
        }
        
    }
    
    
    var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating an instance of MotionManager
        motionManager = CMMotionManager()
        
        // Setting the time intertval as 2 secs for accelerometer
        motionManager.accelerometerUpdateInterval = 0.2
        
        // Setting the corner radius for the Button
        click.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // setting of navigationTitle
        navigationItem.title = "Earthquake Detection"
    }
    
    
    func updateData(data: CMAccelerometerData?, error: Error?) {
        
        guard let accelerometerData = data else { return }
        print(accelerometerData)
        
        let xdata = accelerometerData.acceleration.x
        let ydata = accelerometerData.acceleration.y
        let zdata = accelerometerData.acceleration.z
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        let x = formatter.string(for: accelerometerData.acceleration.x)
        let y = formatter.string(for: accelerometerData.acceleration.y)
        let z = formatter.string(for: accelerometerData.acceleration.z)
        
        xvalue = "\(String(describing: x))"
        yvalue = "\(String(describing: y))"
        zvalue = "\(String(describing: z))"
        
        xLabel.text = xvalue
        yLabel.text = yvalue
        zLabel.text = zvalue
        
        // For socket programming we willl do the following part by:
        //1. sending the data to the table in the database and record coordinates
        //2. Retreving the Alert value : yes or no from the server and display alerts accordingly.
        
        // Both 1 and 2 operation will be done by using Almofire package through cocapods
        // your pc need  to install cocpods or catharage 
        // will go for cocapods because it is easy
        
        // Without the inclusion of the server part implement by the following:
        
        
        
        if (xdata > xthreshold){
            callAlert()
        }
        
        if (ydata > ythreshold){
            callAlert()
        }
        
        if (zdata > zthreshold){
            callAlert()
        }
    }
    
    func callAlert(){
        
        let alert = UIAlertController(title: "Alert", message:"We recorded the unusual moment. Please Stay Safe", preferredStyle: UIAlertControllerStyle.alert)
        // youc can change these red text accordingly to ur wish
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        
    }
    
}
