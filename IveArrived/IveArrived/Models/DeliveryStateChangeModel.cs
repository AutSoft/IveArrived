using IveArrived.Entities;

namespace IveArrived.Models
{
    public class DeliveryStateChangeModel
    {
        public int DeliveryId { get; set; }
        public DeliveryState NewState { get; set; }
    }
}