import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RegisterComponent } from './components/register/register.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { DeliveryComponent } from './components/delivery/delivery.component';
import { DailyDeliveryComponent } from './components/delivery/daily-delivery/daily-delivery.component';
import { MyCouriersComponent } from './components/delivery/my-couriers/my-couriers.component';
import { NewDeliveryComponent } from './components/delivery/new-delivery/new-delivery.component';
import { ProfileSettingsComponent } from './components/delivery/profile-settings/profile-settings.component';


const routes: Routes = [
    { path: '', component: HomeComponent, pathMatch: 'full' },
    { path: 'register', component: RegisterComponent },
    { path: 'delivery', component: DeliveryComponent,
      children: [
        { path: 'daily-delivery', component: DailyDeliveryComponent},
        { path: 'new-delivery', component: NewDeliveryComponent},
        { path: 'my-couriers', component: MyCouriersComponent},
        { path: 'profile-settings', component: ProfileSettingsComponent},
      ]
    },
    { path: 'login', component: LoginComponent}
];

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {

}
