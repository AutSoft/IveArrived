import { Component, OnInit } from '@angular/core';
import { AccountService, FileParameter } from 'src/app/api/app.generated';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [AccountService]
})
export class RegisterComponent implements OnInit {

  constructor(private accountService: AccountService, private router: Router ) { }

  files: FileParameter;

  smeName: string = "";
  email: string = "";
  phoneNumber: string = "";
  profile: string  = "";
  contactName: string = "";
  address: string = "";
  city: string ="";
  zipcode: string ="";
  password: string ="";

  ngOnInit(): void {
  }

  fileChanged(file: FileParameter[]) {
    this.files = file[0];
  }

  onSubmit() {
    console.log(this.address);
    this.accountService.register("SME",
      this.smeName,
      this.contactName,
      this.address,
      this.city,
      this.zipcode,
      "",
      this.email,
      this.password,
      null,
      this.files).subscribe();

      this.router.navigate(["/login"]);
      console.log("navigated");
  }

}
