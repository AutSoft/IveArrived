import { Component, OnInit } from '@angular/core';
import { AccountService, FileParameter } from 'src/app/api/app.generated';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profile-settings',
  templateUrl: './profile-settings.component.html',
  styleUrls: ['./profile-settings.component.css']
})
export class ProfileSettingsComponent implements OnInit {

  constructor(private accountService : AccountService, private router : Router) { }

  files: FileParameter;

  smeName: string = "";
  phoneNumber: string = "";
  profile: string  = "";
  contactName: string = "";
  address: string = "";
  city: string ="";
  zipcode: string ="";

  ngOnInit(): void {
  }

  fileChanged(file: FileParameter[]) {
    this.files = file[0];
  }

  onSubmit() {
    this.accountService.updateSME(this.smeName, this.contactName, this.address, 
      this.city, this.zipcode, this.phoneNumber,null, this.files).subscribe();
  }

}
