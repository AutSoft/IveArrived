import { Pipe, PipeTransform } from '@angular/core';
import { DeliveryState } from 'src/app/api/app.generated';

@Pipe({
  name: 'deliveryState'
})
export class DeliveryStateToString implements PipeTransform {
    transform(value: number): any {
        return DeliveryState[value];
    }
}
