using Foundation;
using System;
using UIKit;
using MessageTest;

namespace TestXamariApp
{
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