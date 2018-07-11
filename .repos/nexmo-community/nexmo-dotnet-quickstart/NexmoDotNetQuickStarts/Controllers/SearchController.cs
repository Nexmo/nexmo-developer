using Nexmo.Api;
using System;
using System.Web.Mvc;

namespace NexmoDotNetQuickStarts.Controllers
{
    public class SearchController : Controller
    {
        public Client Client { get; set; }

        public SearchController()
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
        public ActionResult SearchMessage()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SearchMessage(string messageID)
        {
            var message = Client.Search.GetMessage(messageID);

            if (message.messageId != null)
            {
                ViewData.Add("message", message);
            }
            else
            {
                bool notFound = true;
                ViewData.Add("notFound", notFound);
            }

            return View();
        }

        [HttpGet]
        public ActionResult SearchRejection()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SearchRejection(string messageID, string number, DateTime rejectionDate)
        {
            string date = rejectionDate.Year + "-" + rejectionDate.Month + "-" + rejectionDate.Day;
            var msgs = Client.Search.GetRejections(new Search.SearchRequest
            {
                date = date,
                to = number
            });

            if (msgs.items != null)
            {
                ViewData.Add("items", msgs.items);
            }
            else
            {
                bool notFound = true;
                ViewData.Add("notFound", notFound);
            }

            return View();
        }
    }
}