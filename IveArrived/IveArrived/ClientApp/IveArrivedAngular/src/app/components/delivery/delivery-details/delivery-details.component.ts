import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DeliveryModel, DeliveryService, PackageIdModel } from 'src/app/api/app.generated';

@Component({
  selector: 'app-delivery-details',
  templateUrl: './delivery-details.component.html',
  styleUrls: ['./delivery-details.component.css']
})
export class DeliveryDetailsComponent implements OnInit {

  delivery: DeliveryModel

  constructor(private route: ActivatedRoute,
    private deliveryService: DeliveryService) { }

  ngOnInit(): void {
    this.route.params.subscribe(
      params =>  this.deliveryService.getDelivery(new PackageIdModel({
        packageId: params.id
      })).subscribe(
        delivery => this.delivery = delivery)
    );
  }

}
