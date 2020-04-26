import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DeliveryDetailsComponent } from './delivery-details.component';

describe('DeliveryDetailsComponent', () => {
  let component: DeliveryDetailsComponent;
  let fixture: ComponentFixture<DeliveryDetailsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DeliveryDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DeliveryDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
