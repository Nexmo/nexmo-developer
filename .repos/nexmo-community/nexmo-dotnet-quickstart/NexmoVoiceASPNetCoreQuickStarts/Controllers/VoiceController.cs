using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Nexmo.Api;
using Nexmo.Api.Voice;
using NexmoVoiceASPNetCoreQuickStarts.Helpers;
using Microsoft.AspNetCore.Hosting;
using System.Web;

namespace NexmoVoiceASPNetCoreQuickStarts.Controllers
{
    public class VoiceController : Controller
    {
        private readonly IHostingEnvironment _hostingEnvironment;
        private NCCOHelpers _nccohelper;

        public VoiceController(IHostingEnvironment hostingEnvironment)
        {
            _hostingEnvironment = hostingEnvironment;
            _nccohelper = new NCCOHelpers();
            
        }
        public IActionResult Index()
        {
            ViewData["NCCOButtonText"] = "Create NCCO";
            return View();
        }

        [HttpGet]
        public ActionResult MakeTextToSpeechCall()
        {
            return View();
        }

        [HttpPost]
        public ActionResult MakeTextToSpeechCall(string to)
        {
            var NEXMO_FROM_NUMBER = Configuration.Instance.Settings["appsettings:NEXMO_FROM_NUMBER"];
            var NEXMO_TO_NUMBER = to;
            var NEXMO_CALL_ANSWER_URL = "https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/first_call_talk.json";

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

            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public ActionResult PlayAudioToCaller()
        {
            return View();
        }

        [HttpPost]
        public ActionResult PlayAudioToCaller(string to)
        {
            var NEXMO_FROM_NUMBER = Configuration.Instance.Settings["appsettings:NEXMO_FROM_NUMBER"];
            var NEXMO_TO_NUMBER = to;
            var NEXMO_CALL_ANSWER_URL = "https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/first_call_speech.json";

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

            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public ActionResult CreateTalkNCCO(string text, string voiceName)
        {
            _nccohelper.CreateTalkNCCO(_hostingEnvironment.WebRootPath, text, voiceName);

            ViewData["NCCOButtonText"] = "NCCO Created";
            return View("MakeTextToSpeechCall");
        }

        [HttpPost]
        public ActionResult CreateStreamNCCO(string[] streamUrl, int level=0, bool bargeIN = false, int loop =1)
        {
            _nccohelper.CreateStreamNCCO(_hostingEnvironment.WebRootPath, streamUrl, level, bargeIN, loop);

            ViewData["NCCOButtonText"] = "NCCO Created";
            return View("PlayAudioToCaller");
        }
    }
}