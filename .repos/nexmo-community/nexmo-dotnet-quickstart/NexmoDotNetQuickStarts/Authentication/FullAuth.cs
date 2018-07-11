using Nexmo.Api;

namespace NexmoDotNetQuickStarts.Authentication
{
    /// <summary>
    /// This class is only used for the purpose of building documentation on https://developer.nexmo.com/
    /// It is not used in any of the code samples provided in these Quickstarts
    /// </summary>
    public class FullAuth
    {
        public FullAuth()
        {
            var client = new Client(creds: new Nexmo.Api.Request.Credentials
            {
                ApiKey = "NEXMO_API_KEY",
                ApiSecret = "NEXMO_API_SECRET",
                ApplicationId = "NEXMO_APPLICATION_ID",
                ApplicationKey = "NEXMO_APPLICATION_PRIVATE_KEY"
            });
        }
    }
}