import { Component, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-upload-file',
  templateUrl: './upload-file.component.html',
  styleUrls: ['./upload-file.component.css']
})
export class UploadFileComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  @Output() filechanged = new EventEmitter<any[]>();
  
  files: any = [];

  uploadFile(event) {
    this.files = [];
    for (let index = 0; index < event.length; index++) {
      const element = event[index];
      this.files.push({ data: element, fileName: element.name })
    }  
    this.filechanged.emit(this.files);
  }
  deleteAttachment(index) {
    this.files.splice(index, 1)
  }

}
