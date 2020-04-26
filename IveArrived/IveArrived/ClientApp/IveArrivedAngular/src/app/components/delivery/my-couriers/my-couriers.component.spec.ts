import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { MyCouriersComponent } from './my-couriers.component';

describe('MyCouriersComponent', () => {
  let component: MyCouriersComponent;
  let fixture: ComponentFixture<MyCouriersComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ MyCouriersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MyCouriersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
