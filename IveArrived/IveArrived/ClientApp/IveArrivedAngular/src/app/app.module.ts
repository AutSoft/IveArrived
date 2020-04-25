import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './components/register/register.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatStepperModule } from '@angular/material/stepper';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import {MatButtonModule} from '@angular/material/button';

@NgModule({
    declarations: [
        AppComponent,
        RegisterComponent,
        HomeComponent,
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        BrowserAnimationsModule,
        MatStepperModule,
        NgbModule,
        MatButtonModule
    ],
    providers: [],
    bootstrap: [AppComponent]
})
export class AppModule { }
