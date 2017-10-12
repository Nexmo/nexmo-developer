using Nexmo.Api;
using System.Web.Mvc;
using System.Diagnostics;
using System.Web.Http;
using Newtonsoft.Json;
using System.IO;

namespace NexmoDotNetQuickStarts.Controllers
{
    // For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860
    
        public class SMSController : Controller
        {

            public ActionResult Index()
            {
                return View();
            }

            [System.Web.Mvc.HttpGet]
            public ActionResult Send()
            {
                return View();
            }
            
            [System.Web.Mvc.HttpPost]
            public ActionResult Send(string to, string text)
            {
                var NEXMO_FROM_NUMBER = Configuration.Instance.Settings["appsettings:NEXMO_FROM_NUMBER"];
                var NEXMO_TO_NUMBER = to;

                var results = SMS.Send(new SMS.SMSRequest
                {

                    from = NEXMO_FROM_NUMBER,
                    to = NEXMO_TO_NUMBER,
                    text = "Hello, I'm an SMS sent to you using Nexmo"
                });
                return View("Index");
            }

            [System.Web.Mvc.HttpGet]
            public ActionResult Receive([FromUri]SMS.SMSInbound response)
            {

                if (null != response.to && null != response.msisdn)
                {
                    Debug.WriteLine("------------------------------------");
                    Debug.WriteLine("INCOMING TEXT");
                    Debug.WriteLine("From: " + response.msisdn);
                    Debug.WriteLine(" Message: " + response.text);
                    Debug.WriteLine("------------------------------------");
                    return new HttpStatusCodeResult(200);

                }
                else {
                    Debug.WriteLine("------------------------------------");
                    Debug.WriteLine("Endpoint was hit.");
                    Debug.WriteLine("------------------------------------");
                    return new HttpStatusCodeResult(200);
                
                }

            }

            [System.Web.Mvc.HttpGet]
            public ActionResult DLR([FromUri]SMS.SMSDeliveryReceipt response)
            {

                Debug.WriteLine("------------------------------------");
                Debug.WriteLine("DELIVERY RECIEPT");
                Debug.WriteLine("Message ID: " + response.messageId);
                Debug.WriteLine("From: " + response.msisdn);
                Debug.WriteLine("To: " + response.to);
                Debug.WriteLine("Status: " + response.status);
                Debug.WriteLine("------------------------------------");

                return new HttpStatusCodeResult(200);
            }
    
    }

}
