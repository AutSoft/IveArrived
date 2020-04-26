import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { DailyDeliveryComponent } from './daily-delivery.component';

describe('DailyDeliveryComponent', () => {
  let component: DailyDeliveryComponent;
  let fixture: ComponentFixture<DailyDeliveryComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ DailyDeliveryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DailyDeliveryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
