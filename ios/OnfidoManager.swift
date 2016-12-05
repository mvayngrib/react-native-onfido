//
//  OnfidoManager.swift
//  RNOnfido
//
//  Created by Mark Vayngrib on 12/5/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Foundation
import Onfido

@objc(OnfidoManager)
class OnfidoManager: NSObject {
  
  var bridge: RCTBridge!  // this is synthesized
  var apiToken: String = ""

  @objc func setAPIToken(
    token: String,
    development: Bool = false,
    callback: (NSObject) -> ()
  ) -> Void {
    apiToken = token
    OnfidoAPI.config(apiToken, development: development)
    callback([])
  }
  
  @objc func createFlow(
    captureOptions: [String],
    createOptions: [String: AnyObject],
    callback: (NSObject) -> ()
  ) -> Void {
    let onfido = Onfido(apiToken: apiToken)
      .andCapture(captureOptions)
      .andCreate(createOptions)
      .andCompleteWith({ result in // OnfidoResults
        let json: AnyObject = [
          "document": result.document!.toJSON(),
          "applicant": result.applicant!.toJSON(),
          "check": result.check!.toJSON(),
          "livePhoto": result.livePhoto!.toJSON()
        ]
        
        callback([NSNull(), json])
      })
    
    if let app = UIApplication.sharedApplication().delegate as? AppDelegate, let window = app.window {
      if let rootViewController = window.rootViewController {
        rootViewController.presentViewController(onfido.flow(), animated: true, completion: nil)
        return
      }
    }
    
    callback(["Failed to create Onfido flow"])
  }
  
  // APPLICANTS
  
  @objc func listApplicants(
    callback: (NSObject) -> ()
  ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.listApplicants(
      { applicants in
      // applicants is a [Applicant]
        callback([NSNull(), applicants.toJSON()])
      },
      failure: { error in
                        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }

  @objc func getApplicant(
    uuid: String,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.getApplicant(
      uuid,
      complete: { applicant in
        // applicant is an Applicant
        callback([NSNull(), applicant.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }

  @objc func createApplicant(
    attributes: [String : AnyObject],
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.createApplicant(
      attributes,
      complete: { applicant in
        // applicant is an Applicant
        callback([NSNull(), applicant.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  // CHECKS
  
  @objc func listChecks(
    applicantId: String,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.listChecks(
      applicantId,
      complete: { checks in
        // checks is a [Check]
        callback([NSNull(), checks.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  @objc func getCheck(
    applicantId: String,
    checkUuid: String,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.getCheck(
      applicantId,
      checkUuid,
      complete: { check in
        // check is a Check
        callback([NSNull(), check.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  @objc func createCheck(
    applicantId: String,
    attributes: [String : AnyObject],
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.createCheck(
      applicantId,
      attributes,
      complete: { check in
        // check is a Check
        callback([NSNull(), check.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }

  // UPLOADS
  
  @objc func uploadDocument(
    applicantId: String,
    doctype: String,
    fileURL: NSURL,
    validate: Bool,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.uploadDocument(
      applicantId,
      doctype: doctype,
      fileURL: fileURL,
      validate: validate,
      complete: { document in
        // document is a Document
        callback([NSNull(), document.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }

  @objc func uploadLivePhoto(
    applicantId: String,
    url: NSURL,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.uploadLivePhoto(
      applicantId,
      url,
      complete: { livePhoto in
        // livePhoto is a LivePhoto
        callback([NSNull(), livePhoto.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  // REPORTS

  @objc func getReport(
    checkId: String,
    reportId: String,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.getReport(
      checkId,
      reportId,
      complete: { report in
        // report is a Report
        callback([NSNull(), report.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  @objc func listReports(
    checkId: String,
    callback: (NSObject) -> ()
    ) -> Void {
    if (notSetup(callback)) {
      return
    }
    
    OnfidoAPI.listReports(
      checkId,
      complete: { reports in
        // reports is a [Report]
        callback([NSNull(), reports.toJSON()])
      },
      failure: { error in
        // error is a NSError
        callback([error.localizedDescription])
      }
    )
  }
  
  @objc func notSetup(callback: (NSObject) -> ()) -> Bool {
    if (apiToken.characters.count == 0) {
      callback(["Call setAPIToken first"])
      return true
    }
    
    return false
  }
}
