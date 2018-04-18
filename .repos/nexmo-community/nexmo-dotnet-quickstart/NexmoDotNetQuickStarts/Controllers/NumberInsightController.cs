using Nexmo.Api;
using System.Web.Mvc;

namespace NexmoDotNetQuickStarts.Controllers
{
    public class NumberInsightController : Controller
    {
        public Client Client { get; set; }

        public NumberInsightController()
        {
            Client = new Client(creds: new Nexmo.Api.Request.Credentials
            {
                ApiKey = "NEXMO_API_KEY",
                ApiSecret = "NEXMO_API_SECRET"
            });
        }

        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        
        [HttpGet]
        public ActionResult Basic()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Basic(string number)
        {
            var results = Client.NumberInsight.RequestBasic(new NumberInsight.NumberInsightRequest
            {
                Number = number,
            });

            Session["requestID"] = results.RequestId;
            Session["iNumber"] = results.InternationalFormatNumber;
            Session["nNumber"] = results.NationalFormatNumber;
            Session["status"] = results.StatusMessage;
            Session["country"] = results.CountryName;
            Session["countryCode"] = results.CountryCode;

            return RedirectToAction("BasicResults");
        }

        [HttpGet]
        public ActionResult BasicResults()
        {
            ViewBag.requestID = Session["requestID"];
            ViewBag.iNumber = Session["iNumber"];
            ViewBag.nNumber = Session["nNumber"];
            ViewBag.status = Session["status"];
            ViewBag.country = Session["country"];
            ViewBag.countryCode = Session["countryCode"];

            return View();
        }


        [HttpGet]
        public ActionResult Standard()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Standard(string number)
        {
            var results = Client.NumberInsight.RequestStandard(new NumberInsight.NumberInsightRequest()
            {
                Number = number,
            });

            Session["requestID"] =  results.RequestId;
            Session["iNumber"] = results.InternationalFormatNumber;
            Session["nNumber"] = results.NationalFormatNumber;
            Session["country"] = results.CallerName;
            Session["countryCode"] = results.CountryCode;
            Session["status"] = results.StatusMessage;

            if (results.OriginalCarrier != null)
            {
                Session["originalCarrierName"] = results.OriginalCarrier.Name;
                Session["originalCarrierCode"] = results.OriginalCarrier.NetworkCode;
                Session["originalCarrierType"] = results.OriginalCarrier.NetworkType;
                Session["originalCarrierCountry"] = results.OriginalCarrier.Country;
            }
            if (results.CurrentCarrier != null)
            {

                Session["currentCarrierName"] = results.CurrentCarrier.Name;
                Session["currentCarrierCode"] = results.CurrentCarrier.NetworkCode;
                Session["currentCarrierType"] = results.CurrentCarrier.NetworkType;
                Session["currentCarrierCountry"] = results.CurrentCarrier.Country;
            }

            return RedirectToAction("StandardResults");
        }

        [HttpGet]
        public ActionResult StandardResults()
        {
            ViewBag.requestID = Session["requestID"];
            ViewBag.iNumber = Session["iNumber"];
            ViewBag.nNumber = Session["nNumber"];
            ViewBag.status = Session["status"];
            ViewBag.country = Session["country"];
            ViewBag.countryCode = Session["countryCode"];
            ViewBag.currentCarrierName = Session["currentCarrierName"];
            ViewBag.currentCarrierCode = Session["currentCarrierCode"];
            ViewBag.currentCarrierType = Session["currentCarrierType"];
            ViewBag.currentCarrierCountry = Session["currentCarrierCountry"];
            ViewBag.originalCarrierName = Session["originalCarrierName"];
            ViewBag.originalCarrierCode = Session["originalCarrierCode"];
            ViewBag.originalCarrierType = Session["originalCarrierType"];
            ViewBag.originalCarrierCountry = Session["originalCarrierCountry"];

            return View();
        }

        [HttpGet]
        public ActionResult Advanced()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Advanced(string number)
        {
            var results = Client.NumberInsight.RequestAdvanced(new NumberInsight.NumberInsightRequest()
            {
                Number = number,
            });

            Session["requestID"] = results.RequestId;
            Session["iNumber"] = results.InternationalFormatNumber;
            Session["nNumber"] = results.NationalFormatNumber;
            Session["country"] = results.CallerName;
            Session["countryCode"] = results.CountryCode;
            Session["status"] = results.StatusMessage;

            if (results.OriginalCarrier != null)
            {
                Session["originalCarrierName"] = results.OriginalCarrier.Name;
                Session["originalCarrierCode"] = results.OriginalCarrier.NetworkCode;
                Session["originalCarrierType"] = results.OriginalCarrier.NetworkType;
                Session["originalCarrierCountry"] = results.OriginalCarrier.Country;
            }
            if (results.CurrentCarrier != null)
            {

                Session["currentCarrierName"] = results.CurrentCarrier.Name;
                Session["currentCarrierCode"] = results.CurrentCarrier.NetworkCode;
                Session["currentCarrierType"] = results.CurrentCarrier.NetworkType;
                Session["currentCarrierCountry"] = results.CurrentCarrier.Country;
            }
           
            Session["validNumber"] = results.NumberValidity;
            Session["ported"] = results.PortedStatus;
            Session["reachable"] = results.NumberReachability;
            Session["roaming"] = results.RoamingInformation.status;

            return RedirectToAction("AdvancedResults");
        }

        [HttpGet]
        public ActionResult AdvancedResults()
        {
            ViewBag.requestID = Session["requestID"];
            ViewBag.iNumber = Session["iNumber"];
            ViewBag.nNumber = Session["nNumber"];
            ViewBag.status = Session["status"];
            ViewBag.country = Session["country"];
            ViewBag.countryCode = Session["countryCode"];
            ViewBag.currentCarrierName = Session["currentCarrierName"];
            ViewBag.currentCarrierCode = Session["currentCarrierCode"];
            ViewBag.currentCarrierType = Session["currentCarrierType"];
            ViewBag.currentCarrierCountry = Session["currentCarrierCountry"];
            ViewBag.originalCarrierName = Session["originalCarrierName"];
            ViewBag.originalCarrierCode = Session["originalCarrierCode"];
            ViewBag.originalCarrierType = Session["originalCarrierType"];
            ViewBag.originalCarrierCountry = Session["originalCarrierCountry"];
            ViewBag.validNumber = Session["validNumber"];
            ViewBag.ported = Session["ported"];
            ViewBag.reachable = Session["reachable"];
            ViewBag.roaming = Session["roaming"];

            return View();
        }
    }
}