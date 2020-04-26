import { Component, OnInit, ElementRef, Renderer2 } from '@angular/core';
import { AccountService, CourierServiceModel } from 'src/app/api/app.generated';
import { Router } from '@angular/router';

@Component({
  selector: 'app-delivery',
  templateUrl: './delivery.component.html',
  styleUrls: ['./delivery.component.css']
})
export class DeliveryComponent implements OnInit {

  me: CourierServiceModel;

  constructor(private accountService: AccountService,
    private elementRef: ElementRef, private renderer: Renderer2, private router: Router) { }

  ngOnInit(): void {
    this.accountService.me().subscribe(me => this.me = me)
  }
  public ngAfterViewInit(): void {
    const listItems = this.elementRef.nativeElement.querySelectorAll('.mat-list-item-content') as HTMLElement[];
    listItems.forEach(listItem => {
      this.renderer.setStyle(listItem, 'padding', '0px');
    });
  }

  logout() {
    console.log('BVHJDFASJH');
    this.accountService.logout().subscribe(() => { this.router.navigate(['']); }
    );
  }
}
