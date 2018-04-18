using Nexmo.Api;

namespace NexmoDotNetQuickStarts.Authentication
{
    /// <summary>
    /// This class is only used for the purpose of building documentation on https://developer.nexmo.com/
    /// It is not used in any of the code samples provided in these Quickstarts
    /// </summary>
    public class BasicAuth
    {
        public BasicAuth()
        {
            var client = new Client(creds: new Nexmo.Api.Request.Credentials
            {
                ApiKey = "NEXMO_API_KEY",
                ApiSecret = "NEXMO_API_SECRET"
            });
        }
    }
}