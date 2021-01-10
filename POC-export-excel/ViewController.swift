//
//  ViewController.swift
//  POC-export-excel
//
//  Created by Omar AlQasmi on 1/10/21.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    // Creating a string.
    var mailString = NSMutableString()
    var content : Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mailString.append("Column A, Column B\n")
        mailString.append("Row 1 Column A, Row 1 Column B\n")
        mailString.append("Row 2 Column A, Row 2 Column B\n")

        // Converting it to NSData.
        let data = mailString.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)

        // Unwrapping the optional.
        if let content = data {
            print("NSData: \(content)")
            self.content = content
        }
        

    }
    @IBAction func email(_ sender: Any) {
        // If the view controller can send the email.
        // This will show an email-style popup that allows you to enter
        // Who to send the email to, the subject, the cc's and the message.
        // As the .CSV is already attached, you can simply add an email
        // and press send.
        let emailViewController = configuredMailComposeViewController()

            if MFMailComposeViewController.canSendMail() {
                self.present(emailViewController, animated: true, completion: nil)
            }

    }
    // Generating the email controller.
        func configuredMailComposeViewController() -> MFMailComposeViewController {
            let emailController = MFMailComposeViewController()
            emailController.mailComposeDelegate = self
            emailController.setSubject("CSV File")
            emailController.setMessageBody("", isHTML: false)

            // Attaching the .CSV file to the email.
            emailController.addAttachmentData(self.content!, mimeType: "text/csv", fileName: "Sample.csv")

            return emailController
        }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

            // Dismiss the mail compose view controller.
            controller.dismiss(animated: true, completion: nil)
        }


}

