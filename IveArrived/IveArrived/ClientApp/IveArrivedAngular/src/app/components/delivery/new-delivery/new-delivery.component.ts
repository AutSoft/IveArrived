import { Component, OnInit, Inject } from '@angular/core';
import { CourierServiceDeliveryService, CourierService, CourierModel, AddOrEditDeliveryModel, DeliveryState, DeliveryModel, API_BASE_URL } from 'src/app/api/app.generated';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';

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

  result: DeliveryModel;
  detailsUrl: string;

  constructor(private deliveryService: CourierServiceDeliveryService,
    private courierService: CourierService, private router: Router,
    @Inject(API_BASE_URL) private baseUrl) {

    }

  ngOnInit(): void {
    this.courierService.myCouriers().subscribe(
      couriers => this.couriers = couriers
    )
  }

  addNewDelivery() {
    this.delivery.estimatedDeliveryStart = this.date.value;
    this.delivery.estimatedDeliveryEnd = this.date.value;
    this.deliveryService.addOrUpdateDelivery(this.delivery).subscribe(
      d => {
        this.result = d;
        this.detailsUrl = `${this.baseUrl}/delivery/delivery-details/${encodeURI(this.result.packageId)}`;
        this.router.navigate(['/delivery/daily-delivery']);
      }
    );
  }
}
