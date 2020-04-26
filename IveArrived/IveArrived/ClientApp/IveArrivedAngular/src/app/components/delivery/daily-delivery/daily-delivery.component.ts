import { Component, OnInit } from '@angular/core';
import { CourierServiceDeliveryService, DeliveryModel, DeliveryState, DeliveryStateChangeModel, DeliveryCourierChangeModel, CourierModel, CourierService } from 'src/app/api/app.generated';

@Component({
  selector: 'app-daily-delivery',
  templateUrl: './daily-delivery.component.html',
  styleUrls: ['./daily-delivery.component.css']
})
export class DailyDeliveryComponent implements OnInit {

  deliveryStates: DeliveryState[] = [
    DeliveryState.PackageAssembly,
    DeliveryState.PackageReady,
    DeliveryState.DeliveryInProgress,
    DeliveryState.DeliverySuccess,
    DeliveryState.DeliveryFailed
  ]

  today: string;
  deliveries: DeliveryModel[];
  couriers: CourierModel[];

  constructor(private deliveryService: CourierServiceDeliveryService,
    private courierService: CourierService) {
    const todayDate = new Date();
    const dd = String(todayDate.getDate()).padStart(2, '0');
    const mm = String(todayDate.getMonth() + 1).padStart(2, '0'); //January is 0!
    const yyyy = todayDate.getFullYear();

    this.today = mm + '/' + dd + '/' + yyyy;
  }

  ngOnInit(): void {
    this.deliveryService.listDeliveries().subscribe(
      deliveries => this.deliveries = deliveries
    )
    this.courierService.myCouriers().subscribe(
      couriers => this.couriers = couriers
    )
  }

  changeDeliveryState(delivery: DeliveryModel) {
    this.deliveryService.changeDeliveryState(new DeliveryStateChangeModel({
      deliveryId: delivery.id,
      newState: delivery.state
    })).subscribe();
  }

  setCourier(delivery: DeliveryModel) {
    this.deliveryService.changeDeliveryCourier(new DeliveryCourierChangeModel({
      deliveryId: delivery.id,
      courierId: delivery.courier.id
    })).subscribe();
  }

}
