import { Component, OnInit } from '@angular/core';
import { AccountService, RegistrationModel } from 'src/app/api/app.generated';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [AccountService]
})
export class RegisterComponent implements OnInit {

  constructor(private accountService: AccountService) { }

  files: any[];

  smeName: string;
  email: string;
  phoneNumber:string;
  profile: string;
  contactName:string;
  address: string;
  city: string;
  zipcode: string;

  ngOnInit(): void {
  }

  fileChanged(file: any[]) {
    this.files = file;
    console.log(file);
  }

  onSubmit(){
    let model = new RegistrationModel();
    model.email = this.email;
    model.role = this.profile;
    model.userName = this.smeName;
  }

}
