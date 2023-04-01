import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {

  getWelcome(): any {
    const response = {
      message: 'Welcome Employee Service'
    }
    return JSON.parse(JSON.stringify(response));
  }
}
