import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { NewDeliveryComponent } from './new-delivery.component';

describe('NewDeliveryComponent', () => {
  let component: NewDeliveryComponent;
  let fixture: ComponentFixture<NewDeliveryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ NewDeliveryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NewDeliveryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
