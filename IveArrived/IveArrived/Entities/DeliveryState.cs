using System.Text.Json.Serialization;
using Newtonsoft.Json.Converters;

namespace IveArrived.Entities
{
    [JsonConverter(typeof(StringEnumConverter))]
    public enum DeliveryState
    {
        PackageAssembly = 0,
        PackageReady = 1,
        DeliveryInProgress = 2,
        DeliverySuccess = 3,
        DeliveryFailed = 4
    }
}