import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {

  getWelcome(): any {
    const response = {
      message: 'Welcome Attendance Service'
    }
    return JSON.parse(JSON.stringify(response));
  }
}
