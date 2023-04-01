import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {

  getWelcome(): any {
    const response = {
      message: 'Welcome KPI Service'
    }
    return JSON.parse(JSON.stringify(response));
  }
}
