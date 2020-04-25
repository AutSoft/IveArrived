namespace IveArrived.Models
{
    public class DoorBellResponseModel
    {
        public string PackageId { get; set; }
        public bool IsAvailable { get; set; }
    }
    public class DeliveryCompletedModel
    {
        public string PackageId { get; set; }
        public bool Success { get; set; }
    }
    
}