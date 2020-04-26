import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CourierService, CourierModel } from 'src/app/api/app.generated';

@Component({
  selector: 'app-my-couriers',
  templateUrl: './my-couriers.component.html',
  styleUrls: ['./my-couriers.component.css']
})
export class MyCouriersComponent implements OnInit {

  constructor(private router: Router, private currierService: CourierService) { }

  ngOnInit(): void {
    this.currierService.myCouriers().subscribe(curriers => {
      this.curriers = curriers
    })
  }

  curriers: CourierModel[];

  add() {
    this.router.navigate(["/delivery/add-courier"]);
  }
}
