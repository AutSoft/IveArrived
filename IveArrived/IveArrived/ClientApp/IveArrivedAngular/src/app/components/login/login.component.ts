import { Component, OnInit } from '@angular/core';
import { AccountService, LoginModel } from 'src/app/api/app.generated';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [AccountService]
})
export class LoginComponent implements OnInit {


  constructor(private accountService: AccountService) {

  }

  Email: string;
  Password: string;

  ngOnInit(): void {
    this.Email="";
    this.Password="";
  }


  onSubmit() {



    var vody = new LoginModel;
    vody.email = this.Email;
    vody.password = this.Password;
    this.accountService.login(vody).subscribe();

  }

}
