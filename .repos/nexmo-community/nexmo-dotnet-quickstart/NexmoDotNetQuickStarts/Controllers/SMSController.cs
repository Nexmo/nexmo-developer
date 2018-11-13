using Nexmo.Api;
using System.Diagnostics;
using System.Web.Http;
using System.Web.Mvc;

namespace NexmoDotNetQuickStarts.Controllers
{
    public class SMSController : Controller
    {
        public Client Client { get; set; }

        public SMSController()
        {

            Client = new Client(creds: new Nexmo.Api.Request.Credentials
            {
                ApiKey = "NEXMO_API_KEY",
                ApiSecret = "NEXMO_API_SECRET"
            });
        }

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
            var TO_NUMBER = to;

            var results = Client.SMS.Send(request: new SMS.SMSRequest
            {
                from = "Acme Inc",
                to = TO_NUMBER,
                text = "A test SMS sent using the Nexmo SMS API"
            });
            return View("Index");
        }

        [System.Web.Mvc.HttpGet]
        public ActionResult SendUnicodeSMS()
        {
            return View();
        }

        [System.Web.Mvc.HttpPost]
        public ActionResult SendUnicodeSMS(string to, string text)
        {
            var TO_NUMBER = to;

            var results = Client.SMS.Send(request: new SMS.SMSRequest
            {
                from = "Acme Inc",
                to = TO_NUMBER,
                text = "こんにちは世界",
                type = "unicode"
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
            else
            {
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
