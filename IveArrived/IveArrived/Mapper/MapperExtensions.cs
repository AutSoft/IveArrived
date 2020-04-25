using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using IveArrived.Entities;
using IveArrived.Entities.ApplicationUser;
using IveArrived.Models;

namespace IveArrived.Mapper
{
    public static class MapperExtensions
    {
        private static readonly IMapper Mapper = new MapperConfiguration(cfg =>
        {
        
            cfg.CreateMap<Delivery, DeliveryModel>();
            cfg.CreateMap<ApplicationUser, CourierServiceModel>();
            cfg.CreateMap<ApplicationUser, CourierModel>();

        }).CreateMapper();
        
        public static DeliveryModel ToDto(this Delivery model) =>
            Mapper.Map<Delivery, DeliveryModel>(model);
        public static CourierServiceModel ToDto(this ApplicationUser model) =>
            Mapper.Map<ApplicationUser, CourierServiceModel>(model);
        public static CourierModel ToCourierDto(this ApplicationUser model) =>
            Mapper.Map<ApplicationUser, CourierModel>(model);
    }
}
