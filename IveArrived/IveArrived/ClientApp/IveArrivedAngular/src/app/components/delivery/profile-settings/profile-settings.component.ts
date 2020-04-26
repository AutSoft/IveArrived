import { Component, OnInit } from '@angular/core';
import { AccountService, FileParameter, CourierService } from 'src/app/api/app.generated';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profile-settings',
  templateUrl: './profile-settings.component.html',
  styleUrls: ['./profile-settings.component.css']
})
export class ProfileSettingsComponent implements OnInit {

  constructor(private courierService: CourierService, private accountService : AccountService, private router : Router) { }

  files: FileParameter;

  smeName: string = "";
  phoneNumber: string = "";
  profile: string  = "";
  contactName: string = "";
  address: string = "";
  city: string ="";
  zipcode: string ="";
  flierUrl: string = "";

  ngOnInit(): void {
    this.courierService.getSMEDataForModify().subscribe(data=>{
      this.city = data.city;
      this.contactName = data.contactName;
      this.phoneNumber = data.phoneNumber;
      this.smeName = data.displayName;
      this.zipcode = data.zipCode;
      this.flierUrl = data.flier;
      this.address = data.address;
    });
  }

  fileChanged(file: FileParameter[]) {
    this.files = file[0];
  }

  onSubmit() {
    this.accountService.updateSME(this.smeName, this.contactName, this.address, 
      this.city, this.zipcode, this.phoneNumber,null, this.files).subscribe();
  }

}
