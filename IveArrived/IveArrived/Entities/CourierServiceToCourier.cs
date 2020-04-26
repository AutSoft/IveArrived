namespace IveArrived.Entities
{
    public class CourierServiceToCourier
    {
        public int Id { get; set; }
        public virtual ApplicationUser.ApplicationUser CourierService { get; set; }
        public virtual ApplicationUser.ApplicationUser Courier { get; set; }
    }
}