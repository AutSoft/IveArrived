import { Component, OnInit } from '@angular/core';
import { AccountService, LoginModel } from 'src/app/api/app.generated';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [AccountService]
})
export class LoginComponent implements OnInit {


  constructor(private accountService: AccountService,
    private router: Router) {

  }

  Email: string;
  Password: string;

  ngOnInit(): void {
    this.Email="bakery@test.euvirus";
    this.Password="EuB2020.";
  }

  back(){
    this.router.navigate(['']);
  }


  onSubmit() {



    var body = new LoginModel;
    body.email = this.Email;
    body.password = this.Password;
    this.accountService.login(body).subscribe(
      () => {
        this.router.navigate(["/delivery/daily-delivery"]);
        console.log("navigated to delivery");
      }
    );

  }

}
