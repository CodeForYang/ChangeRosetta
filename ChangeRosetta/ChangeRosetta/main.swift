//
//  main.swift
//  ChangeRosetta
//
//  Created by 杨佩 on 2022/11/1.
//

import Foundation

func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}

//sysctl -n machdep.cpu.brand_string
func checkIsAppSilicon() -> Bool {
    let result = shell("sysctl -n machdep.cpu.brand_string")
    let isSilicon = !result.lowercased().contains("intel")
    if !isSilicon {
        print("current architecture is ", result, " don't need to change Rosetta")
    }
    return isSilicon
}


if checkIsAppSilicon() {
    let args:[String] = CommandLine.arguments

    if args.count < 3 {
        print("Usage: ", (args.first ?? ""), " <app_path> <x86_64|arm64>")
    } else {
        let path = String.init(utf8String: args[1])!
        if !FileManager.default.fileExists(atPath: path) {
            print("Error: path does not exist ",path)
        }
        
        let pathURL = URL.init(fileURLWithPath: path)
        let arch = String.init(utf8String: args[2])!
        
        _LSSetArchitecturePreferenceForApplicationURL(pathURL, arch)
    }
}
    
    






