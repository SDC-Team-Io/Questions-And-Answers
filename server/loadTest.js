import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    {duration: '5s', target: 5000},
    {duration: '20s', target: 5000},
    {duration: '5s', target: 0}
  ],
};

export default function () {
  var random = Math.floor((Math.random() * 500000));
  http.get(`http://localhost:3005/qa/questions?product_id=${random}`);
  sleep(1);
};