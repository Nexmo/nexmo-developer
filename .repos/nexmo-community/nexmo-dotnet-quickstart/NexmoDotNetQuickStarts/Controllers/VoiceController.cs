using Nexmo.Api;
using Nexmo.Api.Voice;
using System.Diagnostics;
using System.IO;
using System.Web.Mvc;

namespace NexmoDotNetQuickStarts.Controllers
{
    public class VoiceController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult MakeCall()
        {
            return View();
        }
        [HttpPost]
        public ActionResult MakeCall(string to)
        {
            var NEXMO_FROM_NUMBER = Configuration.Instance.Settings["appsettings:NEXMO_FROM_NUMBER"];
            var NEXMO_TO_NUMBER = to;
            var NEXMO_CALL_ANSWER_URL = "https://nexmo-community.github.io/ncco-examples/first_call_talk.json";

            var results = Call.Do(new Call.CallCommand
            {
                to = new[]
                {
                    new Call.Endpoint {
                        type = "phone",
                        number = NEXMO_TO_NUMBER
                    }
                },
                from = new Call.Endpoint
                {
                    type = "phone",
                    number = NEXMO_FROM_NUMBER
                },
                answer_url = new[]
                {
                    NEXMO_CALL_ANSWER_URL
                }
            });
            var result = new HttpStatusCodeResult(200);

            return RedirectToAction("Index", "Voice");
        }

        [HttpGet]
        public ActionResult CallList()
        {
            var results = Call.List()._embedded.calls;
            for (int i = 0; i < results.Count; i++)
            {
                Debug.WriteLine(results[i].conversation_uuid);
            }
            ViewData.Add("results", results);
            ViewData.Add("count", results.Count);
            return View();
        }

        [HttpGet]
        public ActionResult GetCall()
        {
            return View();
        }
        [HttpPost]
        public ActionResult GetCall(string id)
        {
            var call = Call.Get(id);
            ViewData.Add("call", call);
            return View();
        }
    }
}