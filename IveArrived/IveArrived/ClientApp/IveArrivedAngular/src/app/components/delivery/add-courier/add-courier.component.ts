import { Component, OnInit } from '@angular/core';
import { FileParameter, CourierService } from 'src/app/api/app.generated';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-courier',
  templateUrl: './add-courier.component.html',
  styleUrls: ['./add-courier.component.css']
})
export class AddCourierComponent implements OnInit {


  files: FileParameter;

  courierName: string = "";
  email: string = "";
  phoneNumber: string = "";
  address: string = "";
  password: string = "";

  constructor(private courierService: CourierService, private router: Router) { }

  fileChanged(file: FileParameter[]) {
    this.files = file[0];
  }

  ngOnInit(): void {
  }

  onSubmit() {
    this.courierService.register(this.courierName, this.email, this.phoneNumber, this.password, this.files).subscribe(data => {
      this.router.navigate(["/delivery/my-couriers"]);
    })
  }

  onBack() {
    this.router.navigate(["/delivery/my-couriers"]);
  }
}
