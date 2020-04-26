import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-my-couriers',
  templateUrl: './my-couriers.component.html',
  styleUrls: ['./my-couriers.component.css']
})
export class MyCouriersComponent implements OnInit {

  constructor(private router :Router) { }

  ngOnInit(): void {
  }


  add(){
    this.router.navigate(["/delivery/add-courier"]);
  }
}
