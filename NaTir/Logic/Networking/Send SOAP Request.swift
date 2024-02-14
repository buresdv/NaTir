//
//  Send SOAP Request.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import Foundation

func sendSoapRequest(action: APIActions, payloadBody: String) async throws -> Data
{
    let url = URL(string: "http://91.209.49.139/webse/se.asmx")!
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    request.httpBody = payloadBody.data(using: .utf8)
    
    request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.addValue(action.rawValue, forHTTPHeaderField: "SOAPAction")
    
    print("Will send SOAP request: \(request)")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    let httpResponse = response as! HTTPURLResponse
    
    print("Response: \(httpResponse)")
    
    #warning("TODO: Implement checking for a valid response code")
    return data
}
