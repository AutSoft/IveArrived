import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { RegisterComponent } from './components/register/register.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatStepperModule } from '@angular/material/stepper';
import { HomeComponent } from './components/home/home.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatInputModule } from '@angular/material/input';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatCardModule } from '@angular/material/card';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatMomentDateModule } from "@angular/material-moment-adapter";
import { DragDropDirective } from './directives/drag-drop.directive';
import { LoginComponent } from './components/login/login.component';
import { UploadFileComponent } from './components/upload-file/upload-file.component';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DeliveryComponent } from './components/delivery/delivery.component';
import { DailyDeliveryComponent } from './components/delivery/daily-delivery/daily-delivery.component';
import { NewDeliveryComponent } from './components/delivery/new-delivery/new-delivery.component';
import { MyCouriersComponent } from './components/delivery/my-couriers/my-couriers.component';
import { ProfileSettingsComponent } from './components/delivery/profile-settings/profile-settings.component';
import { AccountService, CourierService, CourierServiceDeliveryService, API_BASE_URL, DeliveryService } from './api/app.generated';
import { DeliveryStateToString } from './delivery-state.pipe';
import { environment } from 'src/environments/environment';
import { DeliveryDetailsComponent } from './components/delivery/delivery-details/delivery-details.component';
import { AddCourierComponent } from './components/delivery/add-courier/add-courier.component';

@NgModule({
    declarations: [
        AppComponent,
        RegisterComponent,
        HomeComponent,
        DragDropDirective,
        LoginComponent,
        UploadFileComponent,
        DeliveryComponent,
        DailyDeliveryComponent,
        NewDeliveryComponent,
        MyCouriersComponent,
        ProfileSettingsComponent,
        DeliveryStateToString,
        AddCourierComponent,
        DeliveryDetailsComponent
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        BrowserAnimationsModule,
        MatStepperModule,
        MatSidenavModule,
        MatToolbarModule,
        MatGridListModule,
        MatDatepickerModule,
        MatMomentDateModule,
        MatSelectModule,
        MatListModule,
        MatInputModule,
        NgbModule,
        MatButtonModule,
        HttpClientModule,
        FormsModule,
        ReactiveFormsModule,
        MatCardModule,
        MatFormFieldModule
    ],
    providers: [
      AccountService,
      CourierService,
      CourierServiceDeliveryService,
      DeliveryService,
      { provide: API_BASE_URL, useValue: environment.apiBaseUrl },
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
