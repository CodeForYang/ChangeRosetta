#!/usr/bin/env python3
import os
import sys

#1. isDebug? 
xcode_dir = "/Applications/"
arch = "x86_64"
def get_xcodename():
    name_list = []
    for file_name in os.listdir(xcode_dir):
        if "Xcode" in file_name:
            name_list.append(file_name)
            
    return name_list
    


def changeRosetta():
    print(f"arch: {arch}")
    for name in get_xcodename():
        file_path = f"{xcode_dir}{name}"
        print(f"xcode_path: {file_path}")
        os.popen(f"./ChangeRosetta {file_path} {arch}")
    

if __name__ == "__main__":
    if len(sys.argv) > 1 and len(sys.argv[1]) > 0 :
        arch = sys.argv[1]
    changeRosetta()


