# XamarinIOS
Sync Objective-C Static library (.a)in Xamarin Application 


How to sync iOS objective-c .a file to xamarin app. 

/*==================================================================================*/

iOS Library

Step first 1. Create iOS static library

1. File-> New Project -> static library
2. Add functionality 
3. Create Universal library

  a.  Add new target 
    1. File-> New target->Cross-Platform-.Aggregate
    2. Add script to create universal library
     Select Universal target -> Build Phases-> Add script


# Type a script or drag a script file from yo######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="${PROJECT_NAME}"

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos"

UNIVERSAL_LIBRARY_DIR="Universal"

FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}"


######################
# Build Frameworks
######################
#xcodebuild clean build CONFIGURATION_BUILD_DIR="${BUILD_DIR}/${CONFIGURATION}-iphoneos" -scheme "${PROJECT_NAME}" -sdk iphonesimulator -configuration {CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"
#xcodebuild clean build CONFIGURATION_BUILD_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator" -scheme "${PROJECT_NAME}" -sdk iphoneos -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphonesimulator -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphoneos -configuration ${CONFIGURATION}  OBJROOT="${OBJROOT}/DependentBuilds"

######################
# Create directory for universal
######################

rm -rf "${UNIVERSAL_LIBRARY_DIR}"

#mkdir "${UNIVERSAL_LIBRARY_DIR}"

if [ ! -d "${UNIVERSAL_LIBRARY_DIR}" ]; then
mkdir "${UNIVERSAL_LIBRARY_DIR}"
# Control will enter here if $DIRECTORY doesn't exist.
fi
#mkdir "${FRAMEWORK}"
if [ ! -d "${FRAMEWORK}" ]; then
mkdir "${FRAMEWORK}"
# Control will enter here if $DIRECTORY doesn't exist.
fi

######################
# Copy files Framework
######################

#cp -r "${DEVICE_LIBRARY_PATH}/." "${FRAMEWORK}"


######################
# Make an universal binary
######################

lipo "${SIMULATOR_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" "${DEVICE_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" -create -output "${FRAMEWORK}/lib${FRAMEWORK_NAME}.a" | echo
#ur workspace to insert its path.


4. Select Universal target and generic device and build 


.a one folder will created at same place where .xcodeproj
Folder name will be universal take .a file from there 

5. Take .a file and public .h file

6. Check architectures by running command. You should on same path where .a file

 xcrun -sdk iphoneos lipo -info libTestStaticLib.a



B. Add .a file and .h file in iOS project and access static library functionality 

FQA.

1. Library may give error Architecture missing, Obj file missing etc. compile error
May compile on simulator not on device 
May on device not on simulator

Ans: Library is not created with correct architectures 

1. If you created library with correct architectures it will compile in iOS and xamarin 

If its not compiling in iOS device and simulator it not work xamarin

END 

/*==================================================================================*/



/*==================================================================================*/

Start
Xamarin static Library
Wrap iOS .a fine and dependent .h file and framework in xamarin library 

1. Download visual studio 
2. File->New Solution->Binding Library-> Put Name and brower location 
3. Create one folder inside library folder-> iOSLib= paste .a file-> create header folder = paste header file

Navigate on terminal to library folder

4. Install sharpie latest version and install 

Run command see sharpie command info

sharpie xcode -help

Chandrakants-MacBook-Pro:MessageTest chandrakant$ sharpie xcode -help
usage: sharpie xcode [OPTIONS]

Options:
  -h, -help                 Show detailed help
  -v, -verbose              Be verbose with output

Xcode Options:
  -x, -xcode XCODE_ROOT     Search only for SDKs within this specified Xcode paths. May be specified multiple times.
      -sdks                 List all available Xcode SDKs. Pass -verbose for more details.
      -sdkpath SDK          Output the path of the SDK
      -frameworks SDK       List all available framework directories in a given SDK.
Chandrakants-MacBook-Pro:MessageTest chandrakant$ 


Chandrakants-MacBook-Pro:MessageTest chandrakant$ sharpie xcode -sdks
sdk: appletvos13.2    arch: arm64   
sdk: iphoneos13.2     arch: arm64   armv7   
sdk: driverkit19.0    arch: x86_64  i386    
sdk: macosx10.15      arch: x86_64  i386    
sdk: watchos6.1       arch: armv7k  
Chandrakants-MacBook-Pro:MessageTest chandrakant$  

Get iOS available SDK
4.  Add .a file as reference 
Right Click on project-> Add -> Add File-> Select .a file-> Move file
It will create one lib name.a.linwith.cs 

Which have code like this. 

// WARNING: This feature is deprecated. Use the "Native References" folder instead.
// Right-click on the "Native References" folder, select "Add Native Reference",
// and then select the static library or framework that you'd like to bind.
//
// Once you've added your static library or framework, right-click the library or
// framework and select "Properties" to change the LinkWith values.

using ObjCRuntime;

/*  LinkerFlags = "-lstdc++ -lz -ObjC" this additional part */

[assembly: LinkWith("libTestStaticLib.a", SmartLink = true, LinkerFlags = "-lstdc++ -lz -ObjC")]

5. Now we have bind .h files and depended frame work 

Run this command Here Binding library name is MessageTest

MessageTest chandrakant$ sharpie bind --output=MessageTest --namespace=MessageTest --sdk=iphoneos13.2 //Users/chandrakant/Desktop/XamarinR\&D/MessageTest/MessageTest/iOSLib/header/*.h

This will create two file. Which have reference of our .h files and delegate reference 
ApiDefinitions.cs, StructsAndEnums.cs

These file have unused which not not copy 

Only copies related to your .f file enum, structure and delegates
In your file 
ApiDefinitions.cs, Structs.cs

using System;
using System.Runtime.InteropServices;
using Foundation;
using ObjCRuntime;


Structs.cs ==============


namespace MessageTest
{ }



ApiDefinitions.cs =========================

using System;
using CoreFoundation;
using Foundation;
using ObjCRuntime;
using Security;

namespace MessageTest
{
    // @protocol DoSomthingClassDelegate <NSObject>
    [Protocol, Model(AutoGeneratedName = true)]
    [BaseType(typeof(NSObject))]
    interface DoSomthingClassDelegate
    {
        // @required -(void)callBackFromTestLib;
        [Abstract]
        [Export("callBackFromTestLib")]
        void CallBackFromTestLib();
    }

    // @interface DoSomthingClass : NSObject
    [BaseType(typeof(NSObject))]
    [Protocol]
    interface DoSomthingClass
    {
        [Wrap("WeakDelegate")]
        DoSomthingClassDelegate Delegate { get; set; }

        // @property (nonatomic, weak) NSObject<DoSomthingClassDelegate> * delegate;
        [NullAllowed, Export("delegate", ArgumentSemantic.Weak)]
        NSObject WeakDelegate { get; set; }

        // -(void)doSomthingNew:(NSString *)from;
        [Export("doSomthingNew:")]
        void DoSomthingNew(string from);
    }
}


Compile library
End

/*==================================================================================*/




/*==================================================================================*/

Start
Add Xamarin Static Binding to Xamarin Project

Step 1:- 

1. Project- > References-> Edit References-> .Net Assembly -> Browser Library 

Bin- Simulator->debug-Native Library 

2. Import native library in class 

Like this 

using MessageTest;

Class =============


using Foundation;
using System;
using UIKit;
using MessageTest;

namespace TestXamariApp
{. 

 /* Put any name place of MessageTestCallBack * /
   

 public class MessageTestCallBack : DoSomthingClassDelegate
    {
        public override void CallBackFromTestLib()
        {
            Console.WriteLine("This first test call from IOS to xamarin");

        }

    }

        public partial class ViewController : UIViewController
    {
        DoSomthingClass doObj;

        public ViewController(IntPtr handle) : base(handle)
        {
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();
            doObj = new DoSomthingClass();
        / * Create delegate reference * /
   
            var callback = new MessageTestCallBack();
            doObj.Delegate = callback;
            doObj.DoSomthingNew("Xamarin");
            // Perform any additional setup after loading the view, typically from a nib.
        }

        public override void DidReceiveMemoryWarning()
        {
            base.DidReceiveMemoryWarning();
            // Release any cached data, images, etc that aren't in use.
        }
    }
}


Compile

Check code

End

/*==================================================================================*/




