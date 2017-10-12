using Nexmo.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NexmoDotNetQuickStarts.Controllers
{
    public class NumberInsightController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        // GET: /<controller>/
        [HttpGet]
        public ActionResult Basic()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Basic(string number)
        {
            var results = NumberInsight.RequestBasic(new NumberInsight.NumberInsightBasicRequest
            {
                number = number,
            });

            Session["requestID"] = results.request_id;
            Session["iNumber"] = results.international_format_number;
            Session["nNumber"] = results.national_format_number;
            Session["status"] = results.status_message;
            Session["country"] = results.country_name;
            Session["countryCode"] = results.country_code;

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
            var results = NumberInsight.RequestStandard(new NumberInsight.NumberInsightBasicRequest()
            {
                number = number,
            });
            Session["requestID"] =  results.request_id;
            Session["iNumber"] = results.international_format_number;
            Session["nNumber"] = results.national_format_number;
            Session["country"] = results.country_name;
            Session["countryCode"] = results.country_code;
            Session["status"] = results.status_message;
            if (results.original_carrier != null)
            {
                Session["originalCarrierName"] = results.original_carrier.name;
                Session["originalCarrierCode"] = results.original_carrier.network_code;
                Session["originalCarrierType"] = results.original_carrier.network_type;
                Session["originalCarrierCountry"] = results.original_carrier.country;
            }
            if (results.current_carrier != null)
            {

                Session["currentCarrierName"] = results.current_carrier.name;
                Session["currentCarrierCode"] = results.current_carrier.network_code;
                Session["currentCarrierType"] = results.current_carrier.network_type;
                Session["currentCarrierCountry"] = results.current_carrier.country;
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

    }
}