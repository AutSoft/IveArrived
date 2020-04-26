import { Component, OnInit } from '@angular/core';
import { CourierServiceDeliveryService, CourierService, CourierModel, AddOrEditDeliveryModel, DeliveryState } from 'src/app/api/app.generated';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-new-delivery',
  templateUrl: './new-delivery.component.html',
  styleUrls: ['./new-delivery.component.css']
})
export class NewDeliveryComponent implements OnInit {

  couriers: CourierModel[];

  date = new FormControl(new Date());

  delivery: AddOrEditDeliveryModel = new AddOrEditDeliveryModel({
    courierId: 0,
    id: 0,
    state: DeliveryState.PackageAssembly,
    address: "",
    description: "",
    estimatedDeliveryStart: null,
    estimatedDeliveryEnd: null,
    paymentInfo: "",
    recipientEmailAddress: "",
    recipientName: "",
    recipientPhoneNumber: "",
    city: "",
    zipCode: ""
  });

  constructor(private deliveryService: CourierServiceDeliveryService,
    private courierService: CourierService) {

    }

  ngOnInit(): void {
    this.courierService.myCouriers().subscribe(
      couriers => this.couriers = couriers
    )
  }
  addNewDelivery() {
    this.delivery.estimatedDeliveryStart = this.date.value;
    this.delivery.estimatedDeliveryEnd = this.date.value;
    this.deliveryService.addOrUpdateDelivery(this.delivery)
    .subscribe();
  }
}
